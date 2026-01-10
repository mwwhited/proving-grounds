VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "iQs Barcode Generator"
   ClientHeight    =   3000
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5835
   FillColor       =   &H00C0C0C0&
   ForeColor       =   &H8000000F&
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3000
   ScaleWidth      =   5835
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   2520
      Width           =   4695
   End
   Begin VB.TextBox Text5 
      Height          =   285
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   600
      Width           =   4695
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   1080
      TabIndex        =   6
      Top             =   2040
      Width           =   2415
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   1080
      TabIndex        =   5
      Top             =   1680
      Width           =   2415
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1080
      TabIndex        =   2
      Text            =   "0"
      Top             =   1320
      Width           =   2415
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1080
      TabIndex        =   1
      Top             =   960
      Width           =   2415
   End
   Begin VB.Label Label6 
      Caption         =   "Barcode"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   600
      Width           =   855
   End
   Begin VB.Label Label5 
      Caption         =   "Due"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   2040
      Width           =   855
   End
   Begin VB.Label Label4 
      Caption         =   "Reference"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1680
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "Total"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1320
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Account"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   960
      Width           =   855
   End
   Begin VB.Label Label1 
      BeginProperty Font 
         Name            =   "iQs Code 128"
         Size            =   24
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5535
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim plaa As Object
Private Sub Form_Load()
  Set plaa = CreateObject("bar.bar.1")
  Text1.Text = "123456-789"
  Text4.Text = "970920"
  Text2.Text = 23553
  Text3.Text = "5246556314"
End Sub
Private Sub Label1_Change()
  Text5.Text = Label1.Caption
  Text6.Text = plaa.CreateBc(CLng(Text2), 1, Text1, Text4, Text3)
End Sub

Private Sub Text1_Change()
  Label1.Caption = plaa.CreateBarcode(CLng(Text2), 1, Text1, Text4, Text3)
End Sub
Private Sub Text2_Change()
  Label1.Caption = plaa.CreateBarcode(CLng(Text2), 1, Text1, Text4, Text3)
End Sub
Private Sub Text3_Change()
  Label1.Caption = plaa.CreateBarcode(CLng(Text2), 1, Text1, Text4, Text3)
End Sub
Private Sub Text4_Change()
  Label1.Caption = plaa.CreateBarcode(CLng(Text2), 1, Text1, Text4, Text3)
End Sub
