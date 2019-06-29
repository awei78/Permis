
{******************************************}
{                                          }
{             FastReport v2.53             }
{             Progress dialog              }
{                                          }
{Copyright(c) 1998-2004 by FastReports Inc.}
{                                          }
{******************************************}

unit FR_progr;

interface

{$I FR.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FR_Const;

const
  CM_BeforeModal = WM_USER + 1;

type
  TfrProgressForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FDoc: Pointer;
    FOnBeforeModal: TNotifyEvent;
    procedure CMBeforeModal(var Message: TMessage); message CM_BeforeModal;
    procedure Localize;
  public
    { Public declarations }
    FirstCaption: String;
    property OnBeforeModal: TNotifyEvent read FOnBeforeModal write FOnBeforeModal;
    function Show_Modal(Doc: Pointer): Word;
  end;


implementation

uses FR_Class, FR_Utils;

{$R *.DFM}

function TfrProgressForm.Show_Modal(Doc: Pointer): Word;
begin
  Localize;
  FDoc := Doc;
  Label2.Caption := '';
  PostMessage(Handle, CM_BeforeModal, 0, 0);
  Result := ShowModal;
end;

procedure TfrProgressForm.Button1Click(Sender: TObject);
begin
  TfrReport(FDoc).Terminated := True;
  ModalResult := mrCancel;
end;

procedure TfrProgressForm.CMBeforeModal(var Message: TMessage);
begin
  if Assigned(FOnBeforeModal) then FOnBeforeModal(Self);
end;

procedure TfrProgressForm.Localize;
begin
  Button1.Caption := frLoadStr(SCancel);
end;

end.

