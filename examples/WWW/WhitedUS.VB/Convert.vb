Public Class Converters

#Region "Base64 Encoder/Decoder"

    Public Const base64 As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + _
                                    "abcdefghijklmnopqrstuvwxyz" + _
                                    "0123456789+/="

    Public Shared Function Base64Encoder(ByVal varInput As String) As String

        Dim InputPart As Int64, varOutput As String
        Dim varIn1 As Byte, varIn2 As Byte, varIn3 As Byte
        Dim varOut1 As Byte, varOut2 As Byte, varOut3 As Byte, varOut4 As Byte

        varOutput = ""

        For InputPart = 1 To varInput.Length Step 3

            varIn1 = Asc(Mid(varInput, InputPart, 1))
            If InputPart + 1 <= varInput.Length Then
                varIn2 = Asc(Mid(varInput, InputPart + 1, 1))
            Else
                varIn2 = 0
            End If
            If InputPart + 2 <= varInput.Length Then
                varIn3 = Asc(Mid(varInput, InputPart + 2, 1))
            Else
                varIn3 = 0
            End If

            varOut1 = (varIn1 And &HFC) / 4
            varOut2 = (varIn1 And &H3) * 16 + (varIn2 And &HF0) / 16
            varOut3 = (varIn2 And &HF) * 4 + (varIn3 And &HC0) / 64
            varOut4 = varIn3 And &H3F

            varOutput = varOutput & Mid(base64, varOut1 + 1, 1) & _
                                    Mid(base64, varOut2 + 1, 1) & _
                                    Mid(base64, varOut3 + 1, 1) & _
                                    Mid(base64, varOut4 + 1, 1)

        Next

        If Mid(varOutput, varOutput.Length, 1) = "A" Then
            Dim test As String
            test = Mid(varOutput, varOutput.Length - 2, 3)
            If Mid(varOutput, varOutput.Length - 1, 2) = "AA" Then
                If Mid(varOutput, varOutput.Length - 2, 3) = "AAA" Then
                    varOutput = Mid(varOutput, 1, varOutput.Length - 3) & "==="
                Else
                    varOutput = Mid(varOutput, 1, varOutput.Length - 2) & "=="
                End If
            Else
                varOutput = Mid(varOutput, 1, varOutput.Length - 1) & "="
            End If
        End If

        Base64Encoder = varOutput

        InputPart = Nothing
        varOutput = Nothing
        varIn1 = Nothing
        varIn2 = Nothing
        varIn3 = Nothing
        varOut1 = Nothing
        varOut2 = Nothing
        varOut3 = Nothing
        varOut4 = Nothing

    End Function

    Public Shared Function Base64Decoder(ByVal varInput As String) As String

        Dim InputPart As Int64, varOutput As String, CleanUpNull As Boolean
        Dim varIn1 As Byte, varIn2 As Byte, varIn3 As Byte, varIn4 As Byte
        Dim varOut1 As Byte, varOut2 As Byte, varOut3 As Byte

        If InStr(varInput, "=") <> 0 Then
            'varInput.Replace("=", "A")
            CleanUpNull = True
        Else
            CleanUpNull = False
        End If
        varOutput = ""

        For InputPart = 1 To varInput.Length Step 4

            varIn1 = InStr(base64, Mid(varInput, InputPart, 1)) - 1
            If InputPart + 1 <= varInput.Length Then
                varIn2 = InStr(base64, Mid(varInput, InputPart + 1, 1)) - 1
            Else
                varIn2 = 0
            End If
            If InputPart + 2 <= varInput.Length Then
                varIn3 = InStr(base64, Mid(varInput, InputPart + 2, 1)) - 1
            Else
                varIn3 = 0
            End If
            If InputPart + 3 <= varInput.Length Then
                varIn4 = InStr(base64, Mid(varInput, InputPart + 3, 1)) - 1
            Else
                varIn4 = 0
            End If
            If varIn1 = 64 Then varIn1 = 0
            If varIn2 = 64 Then varIn2 = 0
            If varIn3 = 64 Then varIn3 = 0
            If varIn4 = 64 Then varIn4 = 0

            varOut1 = varIn1 * 4 + (varIn2 And &H30) / 16
            varOut2 = (varIn2 And &HF) * 16 + (varIn3 And &H3C) / 4
            varOut3 = (varIn3 And &H3) * 64 + varIn4

            varOutput = varOutput & Chr(varOut1) & Chr(varOut2) & Chr(varOut3)


        Next

        If CleanUpNull = True Then
            'Dim test As Integer
            'test = varOutput
            'varOutput
            Dim doneWithIt As Boolean
            doneWithIt = False
            Do Until doneWithIt
                If InStr(varOutput.Length, varOutput, Chr(0)) Then
                    varOutput = Mid(varOutput, 1, varOutput.Length - 1)
                Else
                    doneWithIt = True
                End If
            Loop
        End If

        Base64Decoder = varOutput
        InputPart = Nothing
        varOutput = Nothing
        CleanUpNull = Nothing
        varIn1 = Nothing
        varIn2 = Nothing
        varIn3 = Nothing
        varIn4 = Nothing
        varOut1 = Nothing
        varOut2 = Nothing
        varOut3 = Nothing

    End Function

#End Region

#Region "Base32 Encoder/Decoder"

    Public Const base32 As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567="

    Public Shared Function Base32Encoder(ByVal varInput As String) As String

        Dim InputPart As Int64, varOutput As String
        Dim varIn1 As Byte, varIn2 As Byte, varIn3 As Byte
        Dim varIn4 As Byte, varIn5 As Byte
        Dim varOut1 As Byte, varOut2 As Byte, varOut3 As Byte, varOut4 As Byte
        Dim varOut5 As Byte, varOut6 As Byte, varOut7 As Byte, varOut8 As Byte

        varOutput = ""

        For InputPart = 1 To varInput.Length Step 5

            varIn1 = Asc(Mid(varInput, InputPart, 1))
            If InputPart + 1 <= varInput.Length Then
                varIn2 = Asc(Mid(varInput, InputPart + 1, 1))
            Else
                varIn2 = 0
            End If
            If InputPart + 2 <= varInput.Length Then
                varIn3 = Asc(Mid(varInput, InputPart + 2, 1))
            Else
                varIn3 = 0
            End If
            If InputPart + 3 <= varInput.Length Then
                varIn4 = Asc(Mid(varInput, InputPart + 3, 1))
            Else
                varIn4 = 0
            End If
            If InputPart + 4 <= varInput.Length Then
                varIn5 = Asc(Mid(varInput, InputPart + 4, 1))
            Else
                varIn5 = 0
            End If

            varOut1 = (varIn1 And &HF8) >> 3
            varOut2 = ((varIn1 And &H7) << 2) + ((varIn2 And &HC0) >> 6)
            varOut3 = (varIn2 And &H3E) >> 1
            varOut4 = ((varIn2 And &H1) << 4) + ((varIn3 And &HF0) >> 4)
            varOut5 = ((varIn3 And &HF) << 1) + ((varIn4 And &H80) >> 7)

            '&H7E was corrected to &H7C... Thanks Henrik
            varOut6 = (varIn4 And &H7C) >> 2
            varOut7 = ((varIn4 And &H3) << 3) + ((varIn5 And &HE0) >> 5)
            varOut8 = (varIn5 And &H1F)

            varOutput = varOutput & _
                Mid(base32, varOut1 + 1, 1) & _
                Mid(base32, varOut2 + 1, 1) & _
                Mid(base32, varOut3 + 1, 1) & _
                Mid(base32, varOut4 + 1, 1) & _
                Mid(base32, varOut5 + 1, 1) & _
                Mid(base32, varOut6 + 1, 1) & _
                Mid(base32, varOut7 + 1, 1) & _
                Mid(base32, varOut8 + 1, 1)
        Next

        If Mid(varOutput, varOutput.Length, 1) = "A" Then
            Dim test As String
            test = Mid(varOutput, varOutput.Length - 2, 3)
            If Mid(varOutput, varOutput.Length - 1, 2) = "AA" Then
                If Mid(varOutput, varOutput.Length - 2, 3) = "AAA" Then
                    varOutput = Mid(varOutput, 1, varOutput.Length - 3) & "==="
                Else
                    varOutput = Mid(varOutput, 1, varOutput.Length - 2) & "=="
                End If
            Else
                varOutput = Mid(varOutput, 1, varOutput.Length - 1) & "="
            End If
        End If

        Base32Encoder = varOutput
    End Function

    Public Shared Function Base32Decoder(ByVal varInput As String) As String

        Dim InputPart As Int64, varOutput As String, CleanUpNull As Boolean
        Dim varIn1 As Byte, varIn2 As Byte, varIn3 As Byte, varIn4 As Byte
        Dim varIn5 As Byte, varIn6 As Byte, varIn7 As Byte, varIn8 As Byte
        Dim varOut1 As Byte, varOut2 As Byte, varOut3 As Byte, varOut4 As Byte
        Dim varOut5 As Byte

        CleanUpNull = InStr(varInput, "=") <> 0
        varOutput = ""

        For InputPart = 1 To varInput.Length Step 8
            varIn1 = InStr(base32, Mid(varInput, InputPart, 1)) - 1
            If InputPart + 1 <= varInput.Length Then
                varIn2 = InStr(base32, Mid(varInput, InputPart + 1, 1)) - 1
            Else
                varIn2 = 0
            End If
            If InputPart + 2 <= varInput.Length Then
                varIn3 = InStr(base32, Mid(varInput, InputPart + 2, 1)) - 1
            Else
                varIn3 = 0
            End If
            If InputPart + 3 <= varInput.Length Then
                varIn4 = InStr(base32, Mid(varInput, InputPart + 3, 1)) - 1
            Else
                varIn4 = 0
            End If
            If InputPart + 3 <= varInput.Length Then
                varIn4 = InStr(base32, Mid(varInput, InputPart + 3, 1)) - 1
            Else
                varIn4 = 0
            End If
            If InputPart + 4 <= varInput.Length Then
                varIn5 = InStr(base32, Mid(varInput, InputPart + 4, 1)) - 1
            Else
                varIn5 = 0
            End If
            If InputPart + 5 <= varInput.Length Then
                varIn6 = InStr(base32, Mid(varInput, InputPart + 5, 1)) - 1
            Else
                varIn6 = 0
            End If
            If InputPart + 6 <= varInput.Length Then
                varIn7 = InStr(base32, Mid(varInput, InputPart + 6, 1)) - 1
            Else
                varIn7 = 0
            End If
            If InputPart + 7 <= varInput.Length Then
                varIn8 = InStr(base32, Mid(varInput, InputPart + 7, 1)) - 1
            Else
                varIn8 = 0
            End If
            If varIn6 = 32 Then varIn6 = 0
            If varIn7 = 32 Then varIn7 = 0
            If varIn8 = 32 Then varIn8 = 0

            '11111111 22222222 33333333 44444444 55555555
            '11111222 22333334 44445555 56666677 77788888
            varOut1 = ((varIn1 And &H1F) << 3) + ((varIn2 And &H1C) >> 2)
            varOut2 = ((varIn2 And &H3) << 6) + ((varIn3 And &H1F) << 1) + _
                        ((varIn4 And &H10) >> 4)
            varOut3 = ((varIn4 And &HF) << 4) + ((varIn5 And &H1E) >> 1)
            varOut4 = ((varIn5 And &H1) << 7) + ((varIn6 And &H1F) << 2) + _
                        ((varIn7 And &H18) >> 3)
            varOut5 = ((varIn7 And &H7) << 5) + (varIn8 And &H1F)

            varOutput = varOutput & Chr(varOut1) & Chr(varOut2) & _
                            Chr(varOut3) & Chr(varOut4) & Chr(varOut5)
        Next

        If CleanUpNull = True Then
            Dim doneWithIt As Boolean
            doneWithIt = False
            Do Until doneWithIt
                If InStr(varOutput.Length, varOutput, Chr(0)) Then
                    varOutput = Mid(varOutput, 1, varOutput.Length - 1)
                Else
                    doneWithIt = True
                End If
            Loop
        End If

        Base32Decoder = varOutput
    End Function

#End Region

End Class
