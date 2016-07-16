unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, AfDataDispatcher, AfComPort, XPMan,
  sSkinProvider, sSkinManager;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    RLow: TRadioButton;
    RMedium: TRadioButton;
    RHigh: TRadioButton;
    Label2: TLabel;
    Lightonoff: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    Ddown: TLabel;
    Dup: TLabel;
    Eleft: TLabel;
    ERight: TLabel;
    Ain: TLabel;
    Aout: TLabel;
    Bup: TLabel;
    Bdown: TLabel;
    Cdown: TLabel;
    Cup: TLabel;
    AfComPort1: TAfComPort;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure N7Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LightonoffClick(Sender: TObject);
    procedure AinClick(Sender: TObject);
    procedure AoutClick(Sender: TObject);
    procedure BupClick(Sender: TObject);
    procedure BdownClick(Sender: TObject);
    procedure CupClick(Sender: TObject);
    procedure CdownClick(Sender: TObject);
    procedure DupClick(Sender: TObject);
    procedure DdownClick(Sender: TObject);
    procedure ERightClick(Sender: TObject);
    procedure EleftClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure DdownMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DdownMouseLeave(Sender: TObject);
    procedure DupMouseLeave(Sender: TObject);
    procedure DupMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EleftMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EleftMouseLeave(Sender: TObject);
    procedure ERightMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ERightMouseLeave(Sender: TObject);
    procedure AinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AinMouseLeave(Sender: TObject);
    procedure AoutMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AoutMouseLeave(Sender: TObject);
    procedure BupMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BupMouseLeave(Sender: TObject);
    procedure BdownMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BdownMouseLeave(Sender: TObject);
    procedure CdownMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CdownMouseLeave(Sender: TObject);
    procedure CupMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CupMouseLeave(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    comm:byte;
    comm_list: array of byte;
    len_list:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure sendCommand();
begin
 if Form1.RMedium.Checked=true then Form1.comm:=Form1.comm+$01;
 if Form1.RHigh.Checked=true then Form1.comm:=Form1.comm+$02;
 with Form1.AfComPort1 do begin
    PurgeRX;
    WriteData(Form1.comm,1);
 end;
 Form1.comm_list[Form1.len_list]:=Form1.comm;
 Form1.len_list:=Form1.len_list+1;
end;

procedure iniCOM;
var i, err, j:integer;
    st, stcom:string;
begin
  stcom:='4';
    Form1.AfComPort1.ComNumber:=4;
      Form1.AfComPort1.BaudRate:=br2400;
  try
    Form1.AfComPort1.Open;
    except
      if not Form1.AfComPort1.Active then
        begin
          st:='COM'+stcom+' does not be present or occupied.';
          Application.MessageBox(Pchar(st), 'Error', MB_OK);
           Form1.AfComPort1.Close;
          Application.Terminate;
        end;
  end;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 close;
end;

procedure TForm1.N3Click(Sender: TObject);
 var
  i: integer;
  st:string;
  FHandl: THandle;
begin
  st:='Доступные порты:'+#13#10+#13#10;
  for i := 0 to 31 do
  begin
    FHandl := CreateFile(PChar('COM' + IntToStr(i + 1)),
      GENERIC_READ or GENERIC_WRITE,
      0,
      nil,
      OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);
    if FHandl <> INVALID_HANDLE_VALUE then
      st:=st+ 'COM' + IntToStr(i + 1)+#13#10;
    CloseHandle(FHandl);
  end;
   showmessage(st);
end;

procedure TForm1.N5Click(Sender: TObject);
begin
 iniCOM();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 Form1.AfComPort1.Close;
 Finalize(comm_list);
end;

procedure TForm1.LightonoffClick(Sender: TObject);
begin
if Form1.Lightonoff.Caption='ВКЛ.' then
  begin
   comm:=$F1;
   Form1.Lightonoff.Caption:='ВЫКЛ.'
  end
  else
    begin
      comm:=$F0;
      Form1.Lightonoff.Caption:='ВКЛ.'
    end;
   AfComPort1.PurgeRX;
   Form1.AfComPort1.WriteData(comm,1);
end;

procedure TForm1.AinClick(Sender: TObject);
begin
 comm:=$A1;
 sendCommand();
end;

procedure TForm1.AoutClick(Sender: TObject);
begin
 comm:=$A4;
 sendCommand();
end;

procedure TForm1.BupClick(Sender: TObject);
begin
  comm:=$B1;
  sendCommand();
end;

procedure TForm1.BdownClick(Sender: TObject);
begin
  comm:=$B4;
  sendCommand();
end;

procedure TForm1.CupClick(Sender: TObject);
begin
  comm:=$C1;
  sendCommand();
end;

procedure TForm1.CdownClick(Sender: TObject);
begin
  comm:=$C4;
  sendCommand();
end;

procedure TForm1.DupClick(Sender: TObject);
begin
  comm:=$D1;
  sendCommand();
end;

procedure TForm1.DdownClick(Sender: TObject);
begin
  comm:=$D4;
  sendCommand();
end;

procedure TForm1.ERightClick(Sender: TObject);
begin
  comm:=$E1;
  sendCommand();
end;

procedure TForm1.EleftClick(Sender: TObject);
begin
  comm:=$E4;
  sendCommand();
end;

procedure TForm1.N2Click(Sender: TObject);
begin
   showmessage('Программа управления "третьей рукой" ARM EDGE :) Version 1.0'+#10#13+'Вопросы: mr_ch@mail15.com');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 iniCOM();
 SetLength(comm_list,500);
 len_list:=0;
end;

procedure TForm1.N4Click(Sender: TObject);
var arr_comm: array [1..11] of byte;
    i:byte;
begin
arr_comm[1]:=$A1;
arr_comm[2]:=$B1;
arr_comm[3]:=$B1;
arr_comm[4]:=$C1;
arr_comm[5]:=$D1;
arr_comm[6]:=$E1;
arr_comm[7]:=$E4;
arr_comm[8]:=$D4;
arr_comm[9]:=$B4;
arr_comm[10]:=$B4;
arr_comm[11]:=$A4;
for i:=1 to 11 do
    begin
      comm:=arr_comm[i];
      sendCommand();
      sleep(850);
    end;
end;

procedure TForm1.N9Click(Sender: TObject);
var rev_list_num:String;
    num_norm,j:integer;
    comm_rev:byte;
begin
 InputQuery('Реверс последних команд','Введите количество команд:',rev_list_num);
 try
    num_norm:=StrtoInt(rev_list_num);
   except
    on EConvertError do
      num_norm:=0;
   end;
 if (num_norm<>0) and (num_norm<=len_list) then
    begin
          for j:=len_list downto (len_list-num_norm) do
              begin
                comm_rev:=comm_list[j];
                comm_rev:=comm_rev and $0F;
                  if comm_rev<$04 then comm_rev:=comm_list[j]+$03
                      else comm_rev:=comm_list[j]-$03;
                AfComPort1.PurgeRX;
                Form1.AfComPort1.WriteData(comm_rev,1);
                sleep(850);
              end;
    end;
end;

procedure TForm1.DdownMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Ddown.Font.Color:=clRed;
end;

procedure TForm1.DdownMouseLeave(Sender: TObject);
begin
  Ddown.Font.Color:=clBlue;
end;

procedure TForm1.DupMouseLeave(Sender: TObject);
begin
  Dup.Font.Color:=clBlue;
end;

procedure TForm1.DupMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Dup.Font.Color:=clRed;
end;

procedure TForm1.EleftMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Eleft.Font.Color:=clRed;
end;

procedure TForm1.EleftMouseLeave(Sender: TObject);
begin
 Eleft.Font.Color:=clBlue;
end;

procedure TForm1.ERightMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   ERight.Font.Color:=clRed;
end;

procedure TForm1.ERightMouseLeave(Sender: TObject);
begin
   ERight.Font.Color:=clBlue;
end;

procedure TForm1.AinMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Ain.Font.Color:=clRed;
end;

procedure TForm1.AinMouseLeave(Sender: TObject);
begin
  Ain.Font.Color:=clBlue;
end;

procedure TForm1.AoutMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Aout.Font.Color:=clRed;
end;

procedure TForm1.AoutMouseLeave(Sender: TObject);
begin
  Aout.Font.Color:=clBlue;
end;

procedure TForm1.BupMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Bup.Font.Color:=clRed;
end;

procedure TForm1.BupMouseLeave(Sender: TObject);
begin
   Bup.Font.Color:=clBlue;
end;

procedure TForm1.BdownMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Bdown.Font.Color:=clRed;
end;

procedure TForm1.BdownMouseLeave(Sender: TObject);
begin
  Bdown.Font.Color:=clBlue;
end;

procedure TForm1.CdownMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   Cdown.Font.Color:=clRed;
end;

procedure TForm1.CdownMouseLeave(Sender: TObject);
begin
   Cdown.Font.Color:=clBlue;
end;

procedure TForm1.CupMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cup.Font.Color:=clRed;
end;

procedure TForm1.CupMouseLeave(Sender: TObject);
begin
  Cup.Font.Color:=clBlue;
end;

procedure TForm1.N10Click(Sender: TObject);
var list_num:String;
    num_norm,i:integer;
    comm_seq:byte;
begin
  InputQuery('Повтор команд','Введите количество команд:',list_num);
  try
    num_norm:=StrtoInt(list_num);
  except
    on EConvertError do
      num_norm:=0;
  end;
 if (num_norm<>0) and (num_norm<=len_list) then
    begin
          for i:=(len_list-num_norm) to len_list do
              begin
                comm_seq:=comm_list[i];
                AfComPort1.PurgeRX;
                Form1.AfComPort1.WriteData(comm_seq,1);
                sleep(850);
              end;
    end;

end;

end.

