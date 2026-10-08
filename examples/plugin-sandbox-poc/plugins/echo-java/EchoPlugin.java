import java.io.*;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * echo-java: the smallest conforming plugin in Java. JDK only (a tiny built-in JSON reader/writer).
 *
 * Handles `echo` and `add`, answers heartbeats, exits 0 on Shutdown.
 * Protocol: see ../../PROFILE.md. stdout is frames only; logs go to stderr.
 *
 * Build: javac -d out EchoPlugin.java     Run: java -cp out EchoPlugin
 */
public final class EchoPlugin {
    static final int MAX_FRAME = 1024 * 1024;
    static final String ID = "echo-java", VERSION = "0.1.0";
    static final DataInputStream in = new DataInputStream(new BufferedInputStream(System.in));
    static final OutputStream out = new BufferedOutputStream(System.out);

    // ---- framing ---------------------------------------------------------------------------

    /** Returns null at EOF: the host is gone. */
    static Map<String, Object> readFrame() throws IOException {
        byte[] header = new byte[4];
        try { in.readFully(header); } catch (EOFException e) { return null; }
        long length = (header[0] & 0xffL) | (header[1] & 0xffL) << 8 | (header[2] & 0xffL) << 16 | (header[3] & 0xffL) << 24;
        if (length > MAX_FRAME) throw new IOException("frame too large");
        byte[] body = new byte[(int) length];
        try { in.readFully(body); } catch (EOFException e) { return null; }
        Object parsed = new Json(new String(body, StandardCharsets.UTF_8)).parse();
        @SuppressWarnings("unchecked") Map<String, Object> env = (Map<String, Object>) parsed;
        return env;
    }

    static void writeFrame(Map<String, Object> env) throws IOException {
        StringBuilder sb = new StringBuilder();
        Json.write(sb, env);
        byte[] body = sb.toString().getBytes(StandardCharsets.UTF_8);
        out.write(new byte[] { (byte) body.length, (byte) (body.length >> 8), (byte) (body.length >> 16), (byte) (body.length >> 24) });
        out.write(body);
        out.flush();
    }

    static Map<String, Object> envelope(String type, String correlationId, String topic, Object payload, boolean hasPayload) {
        Map<String, Object> env = new LinkedHashMap<>();
        env.put("type", type);
        env.put("requestId", UUID.randomUUID().toString());
        if (correlationId != null) env.put("correlationId", correlationId);
        if (topic != null) env.put("topic", topic);
        if (hasPayload) env.put("payload", payload);
        return env;
    }

    static void reply(Map<String, Object> req, String type, Object payload, boolean hasPayload) throws IOException {
        writeFrame(envelope(type, (String) req.get("requestId"), (String) req.get("topic"), payload, hasPayload));
    }

    static void error(Map<String, Object> req, String code, String message) throws IOException {
        Map<String, Object> p = new LinkedHashMap<>();
        p.put("code", code);
        p.put("message", message);
        reply(req, "Error", p, true);
    }

    // ---- handlers --------------------------------------------------------------------------

    static void handleRequest(Map<String, Object> req) throws IOException {
        String topic = (String) req.get("topic");
        boolean has = req.containsKey("payload");
        Object payload = req.get("payload");
        if ("echo".equals(topic)) {
            reply(req, "Response", payload, has);
        } else if ("add".equals(topic)) {
            if (payload instanceof Map<?, ?> m && m.get("a") instanceof BigDecimal a && m.get("b") instanceof BigDecimal b) {
                Map<String, Object> p = new LinkedHashMap<>();
                p.put("sum", a.add(b));
                reply(req, "Response", p, true);
            } else {
                error(req, "bad-payload", "expected {a, b} numbers");
            }
        } else {
            error(req, "unknown-topic", "no handler for '" + topic + "'");
        }
    }

    public static void main(String[] args) throws IOException {
        Map<String, Object> ready = new LinkedHashMap<>();
        ready.put("id", ID);
        ready.put("version", VERSION);
        writeFrame(envelope("Event", null, "lifecycle.ready", ready, true));
        while (true) {
            Map<String, Object> env = readFrame();
            if (env == null || "Shutdown".equals(env.get("type"))) return; // clean exit, nothing to flush
            String kind = (String) env.get("type");
            if ("Heartbeat".equals(kind)) { // same loop as requests: a stuck handler stops this too
                writeFrame(envelope("Heartbeat", (String) env.get("requestId"), null, null, false));
            } else if ("Request".equals(kind)) {
                handleRequest(env);
            } else {
                System.err.println("ignoring " + kind);
            }
        }
    }

    // ---- minimal JSON ----------------------------------------------------------------------

    /** Objects become LinkedHashMap, arrays ArrayList, numbers BigDecimal (so they round-trip exactly), null becomes JSON_NULL. */
    static final class Json {
        static final Object JSON_NULL = new Object();
        final String s;
        int i;

        Json(String s) { this.s = s; }

        Object parse() throws IOException {
            Object v = value();
            ws();
            if (i != s.length()) throw new IOException("trailing data");
            return v;
        }

        void ws() { while (i < s.length() && " \t\r\n".indexOf(s.charAt(i)) >= 0) i++; }

        Object value() throws IOException {
            ws();
            if (i >= s.length()) throw new IOException("unexpected end");
            char c = s.charAt(i);
            if (c == '{') return object();
            if (c == '[') return array();
            if (c == '"') return string();
            if (s.startsWith("true", i)) { i += 4; return Boolean.TRUE; }
            if (s.startsWith("false", i)) { i += 5; return Boolean.FALSE; }
            if (s.startsWith("null", i)) { i += 4; return JSON_NULL; }
            int start = i;
            while (i < s.length() && "+-0123456789.eE".indexOf(s.charAt(i)) >= 0) i++;
            if (start == i) throw new IOException("bad json at " + i);
            return new BigDecimal(s.substring(start, i));
        }

        Map<String, Object> object() throws IOException {
            Map<String, Object> m = new LinkedHashMap<>();
            i++;
            ws();
            if (s.charAt(i) == '}') { i++; return m; }
            while (true) {
                ws();
                String k = string();
                ws();
                if (s.charAt(i++) != ':') throw new IOException("expected ':'");
                m.put(k, value());
                ws();
                char c = s.charAt(i++);
                if (c == '}') return m;
                if (c != ',') throw new IOException("expected ',' or '}'");
            }
        }

        List<Object> array() throws IOException {
            List<Object> l = new ArrayList<>();
            i++;
            ws();
            if (s.charAt(i) == ']') { i++; return l; }
            while (true) {
                l.add(value());
                ws();
                char c = s.charAt(i++);
                if (c == ']') return l;
                if (c != ',') throw new IOException("expected ',' or ']'");
            }
        }

        String string() throws IOException {
            if (s.charAt(i) != '"') throw new IOException("expected string");
            StringBuilder sb = new StringBuilder();
            i++;
            while (true) {
                char c = s.charAt(i++);
                if (c == '"') return sb.toString();
                if (c != '\\') { sb.append(c); continue; }
                char e = s.charAt(i++);
                switch (e) {
                    case 'n' -> sb.append('\n');
                    case 't' -> sb.append('\t');
                    case 'r' -> sb.append('\r');
                    case 'b' -> sb.append('\b');
                    case 'f' -> sb.append('\f');
                    case 'u' -> { sb.append((char) Integer.parseInt(s.substring(i, i + 4), 16)); i += 4; }
                    default -> sb.append(e); // " \ /
                }
            }
        }

        static void write(StringBuilder sb, Object v) {
            if (v == null || v == JSON_NULL) sb.append("null");
            else if (v instanceof String str) writeString(sb, str);
            else if (v instanceof BigDecimal d) sb.append(d.toPlainString());
            else if (v instanceof Boolean || v instanceof Number) sb.append(v);
            else if (v instanceof Map<?, ?> m) {
                sb.append('{');
                boolean first = true;
                for (Map.Entry<?, ?> e : m.entrySet()) {
                    if (!first) sb.append(',');
                    first = false;
                    writeString(sb, (String) e.getKey());
                    sb.append(':');
                    write(sb, e.getValue());
                }
                sb.append('}');
            } else if (v instanceof List<?> l) {
                sb.append('[');
                for (int k = 0; k < l.size(); k++) {
                    if (k > 0) sb.append(',');
                    write(sb, l.get(k));
                }
                sb.append(']');
            } else throw new IllegalArgumentException("unsupported " + v.getClass());
        }

        static void writeString(StringBuilder sb, String str) {
            sb.append('"');
            for (int k = 0; k < str.length(); k++) {
                char c = str.charAt(k);
                switch (c) {
                    case '"' -> sb.append("\\\"");
                    case '\\' -> sb.append("\\\\");
                    case '\n' -> sb.append("\\n");
                    case '\r' -> sb.append("\\r");
                    case '\t' -> sb.append("\\t");
                    default -> { if (c < 0x20) sb.append(String.format("\\u%04x", (int) c)); else sb.append(c); }
                }
            }
            sb.append('"');
        }
    }
}
