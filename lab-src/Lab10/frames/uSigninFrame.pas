unit uSigninFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Effects,
  FMX.Filter.Effects, fieldlogger.authentication, System.ImageList, FMX.ImgList;

type
  TSigninFrame = class(TFrame)
    ToolBar6: TToolBar;
    ToolBarBackgroundRect: TRectangle;
    Label10: TLabel;
    VertScrollBox1: TVertScrollBox;
    SignInBackgroundRect: TRectangle;
    FormLayout: TLayout;
    UsernameEdit: TEdit;
    UserImage: TImage;
    PasswordEdit: TEdit;
    LockImage: TImage;
    FormSpacerLayout: TLayout;
    HeaderLayout: TLayout;
    Layout1: TLayout;
    WelcomeLabel: TLabel;
    LogoImage: TImage;
    ErrorLabel: TLabel;
    SignInButton: TButton;
    Circle1: TCircle;
    Label1: TLabel;
    Label2: TLabel;
    Layout2: TLayout;
    Label3: TLabel;
    DarkStyleLabel: TLabel;
    LightStyleLabel: TLabel;
    Layout3: TLayout;
    GridPanelLayout1: TGridPanelLayout;
    UserImageBlue: TImage;
    LockImageBlue: TImage;
    procedure PasswordEditKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure SignInButtonClick(Sender: TObject);
    procedure DarkStyleLabelClick(Sender: TObject);
    procedure LightStyleLabelClick(Sender: TObject);
    procedure UsernameEditKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  formMain, uDataModule;

procedure TSigninFrame.DarkStyleLabelClick(Sender: TObject);
begin
  frmMain.SetDarkStyle;
end;

procedure TSigninFrame.LightStyleLabelClick(Sender: TObject);
begin
  frmMain.SetLightStyle;
end;

procedure TSigninFrame.PasswordEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    SignInButtonClick(Self);
  end
  else if Key = vkTab then
  begin
    PasswordEdit.SetFocus;
  end;
end;

procedure TSigninFrame.SignInButtonClick(Sender: TObject);
begin
  SignInButton.Text := 'Authenticating...';
  ErrorLabel.Text := '';
  try
    if TAuthentication.Authenticate(mainDM.conn, UsernameEdit.Text, PasswordEdit.Text)
    then
    begin
      frmMain.SignInComplete;
    end
    else
    begin
      ErrorLabel.Text := 'Invalid UserName/Password or Connection to IBLite database';
    end;
  except
    on E: Exception do
      begin
        ErrorLabel.Text := E.Message;
      end;
  end;
  SignInButton.Text := 'SIGN IN';
end;

procedure TSigninFrame.UsernameEditKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    PasswordEdit.SetFocus;
    Key := 0;
  end;
end;

end.
