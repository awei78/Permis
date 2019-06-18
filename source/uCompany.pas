unit uCompany;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBase, StdCtrls, Buttons, ExtCtrls, ShellAPI, uApp;

type
  TfrmCompany = class(TfrmBase)
    img: TImage;
    Label3: TLabel;
    Label1: TLabel;
    edtName: TEdit;
    Label2: TLabel;
    edtLinkMan: TEdit;
    Label4: TLabel;
    edtLawMan: TEdit;
    Label5: TLabel;
    edtAddr: TEdit;
    Label6: TLabel;
    edtTel: TEdit;
    Label8: TLabel;
    edtUrl: TEdit;
    Label9: TLabel;
    edtMail: TEdit;
    Label10: TLabel;
    meoDes: TMemo;
    Label11: TLabel;
    edtPostCode: TEdit;
    procedure edtUrlDblClick(Sender: TObject);
    procedure edtMailDblClick(Sender: TObject);
  private
    { Private declarations }
    FCompany: TCompany;
  protected
    procedure LoadData; override;
    procedure SaveData; override;
  public
    { Public declarations }
  end;

var
  frmCompany: TfrmCompany;

function ShowCompany(ACompany: TCompany): Boolean;

implementation

uses uGlobal;

{$R *.dfm}

function ShowCompany(ACompany: TCompany): Boolean;
begin
  with TfrmCompany.Create(Application.MainForm) do
  begin
    HelpHtml := 'company.html';
    try
      FCompany := ACompany;
      LoadData();
      Result := ShowModal() = mrOk;
    finally
      Free;
    end;
  end;
end;

{ TfrmCompany }

procedure TfrmCompany.LoadData;
begin
  with FCompany do
  begin
    edtName.Text := Name;
    edtLinkMan.Text := LinkMan;
    edtLawMan.Text := LawMan;
    edtAddr.Text := Address;
    edtPostCode.Text := PostCode;
    edtTel.Text := Tel;
    edtUrl.Text := HomePage;
    edtMail.Text := EMail;
    meoDes.Text := Description;
  end;
end;

procedure TfrmCompany.SaveData;
begin
  with FCompany do
  begin
    Name := edtName.Text;
    LinkMan := edtLinkMan.Text;
    LawMan := edtLawMan.Text;
    Address := edtAddr.Text;
    PostCode := edtPostCode.Text;
    Tel := edtTel.Text;
    HomePage := edtUrl.Text;
    EMail := edtMail.Text;
    Description := meoDes.Text;

    SaveToIni();
  end;

  Log.Write(App.UserID + '更新单位信息');  
end;

procedure TfrmCompany.edtUrlDblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PAnsiChar(edtUrl.Text), nil, nil, SW_SHOW);
end;

procedure TfrmCompany.edtMailDblClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PAnsiChar('mailto:' + edtMail.Text), nil, nil, SW_SHOW);
end;

end.
