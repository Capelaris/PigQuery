object FrmMainForm: TFrmMainForm
  Left = 0
  Top = 0
  Caption = 'Sample'
  ClientHeight = 466
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Reference Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 15
  object mmoQuery: TMemo
    Left = 0
    Top = 33
    Width = 774
    Height = 433
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 635
    ExplicitHeight = 308
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 774
    Height = 33
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 635
    object btnSelect: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'Select'
      TabOrder = 0
      OnClick = btnSelectClick
    end
    object btnInsert: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'Insert'
      TabOrder = 1
      OnClick = btnInsertClick
    end
    object btnUpdate: TButton
      AlignWithMargins = True
      Left = 166
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'Update'
      TabOrder = 2
      OnClick = btnUpdateClick
    end
    object btnDelete: TButton
      AlignWithMargins = True
      Left = 247
      Top = 4
      Width = 75
      Height = 25
      Align = alLeft
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object btnSelectJSON: TButton
      AlignWithMargins = True
      Left = 392
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Select JSON'
      TabOrder = 4
      OnClick = btnSelectJSONClick
      ExplicitLeft = 456
    end
    object btnInsertJSON: TButton
      AlignWithMargins = True
      Left = 488
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Insert JSON'
      TabOrder = 5
      OnClick = btnInsertJSONClick
      ExplicitLeft = 552
    end
    object btnUpdateJSON: TButton
      AlignWithMargins = True
      Left = 584
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Update JSON'
      TabOrder = 6
      OnClick = btnUpdateJSONClick
      ExplicitLeft = 648
    end
    object btnDeleteJSON: TButton
      AlignWithMargins = True
      Left = 680
      Top = 4
      Width = 90
      Height = 25
      Align = alRight
      Caption = 'Delete JSON'
      TabOrder = 7
      OnClick = btnDeleteJSONClick
      ExplicitLeft = 744
    end
  end
end
