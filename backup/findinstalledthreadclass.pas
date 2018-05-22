unit FindInstalledThreadClass;

//{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, main;
//, forms, Controls, ComCtrls;

type

  { FindInstalledThread }

  FindInstalledThread = class(TThread)
  private
    N: integer;
    Status: string;
    StopThread: boolean;
    procedure Update;
    procedure OnTerminate;

  protected
    procedure Execute; override;
  public
    constructor Create();
    //property Status: string Read Status Write Status;
    //property StopThread: boolean Read StopThread Write StopThread;
  end;

implementation

//uses main;

{ FindInstalledThread }

procedure FindInstalledThread.OnTerminate;
begin
  frmMain.StatusBar.SimpleText:='Terminated!';
end;

procedure FindInstalledThread.Update;
begin
  frmMain.StatusBar.SimpleText:=Status;
end;

procedure FindInstalledThread.Execute;
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

constructor FindInstalledThread.Create();
begin
  inherited Create(True);
  FreeOnTerminate := True;
end;


end.

