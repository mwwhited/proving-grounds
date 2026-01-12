Imports Microsoft.VisualStudio.TestTools.UnitTesting
Imports System.Text
Imports WhitedUS.VB

'''<summary>
'''This is a test class for ConvertersTest and is intended
'''to contain all ConvertersTest Unit Tests
'''</summary>
<TestClass()> _
Public Class ConvertersTest


    Private testContextInstance As TestContext

    '''<summary>
    '''Gets or sets the test context which provides
    '''information about and functionality for the current test run.
    '''</summary>
    Public Property TestContext() As TestContext
        Get
            Return testContextInstance
        End Get
        Set(ByVal value As TestContext)
            testContextInstance = Value
        End Set
    End Property

#Region "Additional test attributes"
    '
    'You can use the following additional attributes as you write your tests:
    '
    'Use ClassInitialize to run code before running the first test in the class
    '<ClassInitialize()>  _
    'Public Shared Sub MyClassInitialize(ByVal testContext As TestContext)
    'End Sub
    '
    'Use ClassCleanup to run code after all tests in a class have run
    '<ClassCleanup()>  _
    'Public Shared Sub MyClassCleanup()
    'End Sub
    '
    'Use TestInitialize to run code before running each test
    '<TestInitialize()>  _
    'Public Sub MyTestInitialize()
    'End Sub
    '
    'Use TestCleanup to run code after each test has run
    '<TestCleanup()>  _
    'Public Sub MyTestCleanup()
    'End Sub
    '
#End Region


    '''<summary>
    '''A test for Base32Decoder
    '''</summary>
    <TestMethod()> _
    Public Sub Base32DecoderTest()
        Dim varInput As String = "JBSWY3DPEBLW64TMMQQSCII="
        Dim expected As String = "Hello World!!!"
        Dim actual As String
        actual = Converters.Base32Decoder(varInput)
        Assert.AreEqual(expected, actual)
    End Sub

    '''<summary>
    '''A test for Base32Encoder
    '''</summary>
    <TestMethod()> _
    Public Sub Base32EncoderTest()
        Dim varInput As String = "Hello World!!!"
        Dim expected As String = "JBSWY3DPEBLW64TMMQQSCII="
        Dim actual As String
        actual = Converters.Base32Encoder(varInput)
        Assert.AreEqual(expected, actual)
    End Sub

    '''<summary>
    '''A test for Base64Decoder
    '''</summary>
    <TestMethod()> _
    Public Sub Base64DecoderTest()
        Dim varInput As String = "SGVsbG8gV29ybGQhISE="
        Dim expected As String = "Hello World!!!"
        Dim actual As String
        actual = Converters.Base64Decoder(varInput)
        Assert.AreEqual(expected, actual)
        Assert.AreEqual(Encoding.ASCII.GetString(Convert.FromBase64String(varInput)), expected)
    End Sub

    '''<summary>
    '''A test for Base64Encoder
    '''</summary>
    <TestMethod()> _
    Public Sub Base64EncoderTest()
        Dim varInput As String = "Hello World!!!"
        Dim expected As String = "SGVsbG8gV29ybGQhISE="
        Dim actual As String
        actual = Converters.Base64Encoder(varInput)
        Assert.AreEqual(expected, actual)
        Assert.AreEqual(Convert.ToBase64String(Encoding.ASCII.GetBytes(varInput)), expected)
    End Sub

End Class
