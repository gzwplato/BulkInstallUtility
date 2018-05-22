unit findinstalledclass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TFindInstalled }

  TFindInstalled = class(TThread)
  private
    N: integer;
    Status: string;
    StopThread: boolean;
    procedure Update;
    procedure OnTerminate;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    //property Status: string Read Status Write Status;
    //property StopThread: boolean Read StopThread Write StopThread;
  end;

implementation

uses main;

{ TFindInstalled }

procedure TFindInstalled.OnTerminate;
begin
  frmMain.StatusBar.SimpleText:='Terminated!'+' gUnInsList.Count='+gUnInsList.Count.toString;
end;

procedure TFindInstalled.Update;
begin
  frmMain.StatusBar.SimpleText:=Status;
end;

procedure TFindInstalled.Execute;
var
  i, j: integer;
begin
  N := 0;
  j:=0;

  while not Terminated do begin
    Sleep(50);
    Inc(j);
    if j > 3 then
      break;

    for i:=0 to 10 do begin
      Sleep(100);
      //Inc(N);
      N:=i;
      Status:='Count='+j.toString+'.'+N.toString;
      Synchronize(@Update);
    end;

  end;
  Synchronize(@OnTerminate);
end;

constructor TFindInstalled.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := True;
end;


end.

