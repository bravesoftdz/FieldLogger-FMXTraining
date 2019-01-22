unit fieldlogger.authentication;

interface
uses
  FireDAC.Comp.Client;

type
  TAuthentication = class
  public
    class function Authenticate(conn: TFDConnection; Username, Password: string; Queries: array of TFDQuery; Tables: array of TFDTable): boolean;
  end;

implementation

{ TAuthentication }

class function TAuthentication.Authenticate(conn: TFDConnection; Username, Password: string; Queries: array of TFDQuery; Tables: array of TFDTable): boolean;
var
  idx: int32;
begin
  Result := False;
  conn.Connected := False;
  conn.Params.Values['USER_NAME'] := Username;
  conn.Params.Values['Password'] := Password;
  try
    conn.Connected := True;
  finally
    Result := conn.Connected;
  end;
  if Result then begin
    if length(Queries)=0 then begin
      exit;
    end;
    Result := False; // unless..
    for idx := 0 to pred(Length(Queries)) do begin
      Queries[idx].Connection := conn;
      Queries[idx].Active := True;
      if not Queries[idx].Active then begin
        exit;
      end;
    end;
    Result := True;
    if length(Tables)=0 then begin
      exit;
    end;
    Result := False; // unless;
    for idx := 0 to pred(Length(Tables)) do begin
      Tables[idx].Connection := conn;
      Tables[idx].Active := True;
      if not Tables[idx].Active then begin
        exit;
      end;
    end;
    Result := True;
  end;
end;

end.
