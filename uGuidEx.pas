unit uGuidEx;

interface

uses SysUtils;

type
  TGuidEx = class
    //Creates and returns a new globally unique identifier
    class function NewGuid : TGuid;
    //sometimes we need to have an "empty" value, like NULL
    class function EmptyGuid : TGuid;
    //Checks whether a Guid is EmptyGuid
    class function IsEmptyGuid(Guid : TGuid) : boolean;
    //Convert to string
    class function ToString(Guid : TGuid) : string;
    //convert to quoted string
    class function ToQuotedString(Guid : TGuid) : string;
    //return a GUID from string
    class function FromString(Value : string) : TGuid;
    //Indicates whether two TGUID values are the same
    class function EqualGuids(Guid1, Guid2 : TGuid) : boolean;
    //Convert to string, only caracteres
    class function ToCaracters(Guid : TGuid) : string;
  end;

implementation

{ TGuidEx }

class function TGuidEx.EmptyGuid: TGuid;
begin
  result := FromString('{00000000-0000-0000-0000-000000000000}');
end;

class function TGuidEx.EqualGuids(Guid1, Guid2: TGuid): boolean;
begin
  result := IsEqualGUID(Guid1, Guid2);
end;

class function TGuidEx.FromString(Value: string): TGuid;
begin
  result := StringToGuid(Value);
end;

class function TGuidEx.IsEmptyGuid(Guid : TGuid): boolean;
begin
  result := EqualGuids(Guid,EmptyGuid);
end;

class function TGuidEx.NewGuid: TGuid;
var
  Guid : TGuid;
begin
  CreateGUID(Guid);
  Result := Guid;
end;

class function TGuidEx.ToQuotedString(Guid: TGuid): string;
begin
  result := QuotedStr(ToString(Guid));
end;

class function TGuidEx.ToString(Guid: TGuid): string;
begin
  result := GuidToString(Guid);
end;

class function TGuidEx.ToCaracters(Guid: TGuid): string;
begin
  result := GuidToString(Guid);
  result := StringReplace(result,'-','8',[rfReplaceAll]);
  result := StringReplace(result,'{','9',[rfReplaceAll]);
  result := StringReplace(result,'}','9',[rfReplaceAll]);
end;

end.//GuidEx

