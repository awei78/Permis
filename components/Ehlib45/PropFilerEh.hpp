// CodeGear C++Builder
// Copyright (c) 1995, 2007 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Propfilereh.pas' rev: 11.00

#ifndef PropfilerehHPP
#define PropfilerehHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Ehlibvcl.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Propfilereh
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TPropWriterEh;
typedef void __fastcall (__closure *TWriteOwnerPropsEventEh)(TPropWriterEh* Writer);

class DELPHICLASS TPropReaderEh;
typedef void __fastcall (__closure *TReadOwnerPropEventEh)(TPropReaderEh* Reader, AnsiString PropName, bool &Processed);

class PASCALIMPLEMENTATION TPropWriterEh : public Classes::TWriter 
{
	typedef Classes::TWriter inherited;
	
private:
	Classes::TList* FCurRootsList;
	Classes::TStringList* FDefnBinPropList;
	Classes::TStringList* FDefnPropList;
	Classes::TList* FInterceptorList;
	Classes::TList* FLastRootsList;
	AnsiString FPropPath;
	TWriteOwnerPropsEventEh FOnWriteOwnerProps;
	void __fastcall BuildPropsList(System::TObject* AObject, Classes::TStrings* sl);
	
protected:
	void __fastcall WriteAllProperties(System::TObject* Instance);
	
public:
	__fastcall TPropWriterEh(Classes::TStream* Stream, int BufSize);
	__fastcall virtual ~TPropWriterEh(void);
	HIDESBASE void __fastcall WritePropName(const AnsiString PropName);
	virtual void __fastcall DefineBinaryProperty(const AnsiString Name, Classes::TStreamProc ReadData, Classes::TStreamProc WriteData, bool HasData);
	void __fastcall DefineObjectProperties(System::TObject* Instance);
	virtual void __fastcall DefineProperty(const AnsiString Name, Classes::TReaderProc ReadData, Classes::TWriterProc WriteData, bool HasData);
	void __fastcall SaveObjectProperyValue(System::TObject* Instance, AnsiString Path, AnsiString FullPath);
	HIDESBASE void __fastcall WriteCollection(Classes::TCollection* Value);
	void __fastcall WriteOwnerProperties(Classes::TComponent* Owner, Classes::TStrings* PropList);
	__property TWriteOwnerPropsEventEh OnWriteOwnerProps = {read=FOnWriteOwnerProps, write=FOnWriteOwnerProps};
};


class PASCALIMPLEMENTATION TPropReaderEh : public Classes::TReader 
{
	typedef Classes::TReader inherited;
	
private:
	bool FCanHandleExcepts;
	Classes::TList* FCollectionList;
	Classes::TList* FInterceptorList;
	AnsiString FPropName;
	TReadOwnerPropEventEh FOnReadOwnerProp;
	HIDESBASE int __fastcall ReadSet(Typinfo::PTypeInfo SetType);
	HIDESBASE void __fastcall SkipSetBody(void);
	
protected:
	virtual bool __fastcall Error(const AnsiString Message);
	HIDESBASE void __fastcall ReadCollection(Classes::TCollection* Collection);
	HIDESBASE void __fastcall ReadProperty(Classes::TPersistent* AInstance);
	HIDESBASE void __fastcall ReadPropValue(Classes::TPersistent* Instance, Typinfo::PPropInfo PropInfo);
	
public:
	__fastcall TPropReaderEh(Classes::TStream* Stream, int BufSize);
	__fastcall virtual ~TPropReaderEh(void);
	virtual void __fastcall DefineBinaryProperty(const AnsiString Name, Classes::TStreamProc ReadData, Classes::TStreamProc WriteData, bool HasData);
	virtual void __fastcall DefineProperty(const AnsiString Name, Classes::TReaderProc ReadData, Classes::TWriterProc WriteData, bool HasData);
	HIDESBASE void __fastcall ReadComponent(Classes::TComponent* Component);
	void __fastcall ReadOwnerProperties(Classes::TComponent* Component);
	__property TReadOwnerPropEventEh OnReadOwnerProp = {read=FOnReadOwnerProp, write=FOnReadOwnerProp};
};


class DELPHICLASS TStoragePropertyInterceptor;
class PASCALIMPLEMENTATION TStoragePropertyInterceptor : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
__published:
	System::TObject* FTarget;
	
public:
	__fastcall virtual TStoragePropertyInterceptor(System::TObject* ATarget);
	virtual bool __fastcall NeedIntercept(void);
	virtual void __fastcall Readed(void);
	__property System::TObject* Target = {read=FTarget};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TStoragePropertyInterceptor(void) { }
	#pragma option pop
	
};


class DELPHICLASS TFormStoragePropertyInterceptor;
class PASCALIMPLEMENTATION TFormStoragePropertyInterceptor : public TStoragePropertyInterceptor 
{
	typedef TStoragePropertyInterceptor inherited;
	
private:
	Controls::TWinControl* FActiveControl;
	int FHeight;
	int FLeft;
	int FPixelsPerInch;
	bool FPosPresent;
	int FTop;
	int FWidth;
	Forms::TWindowState FWindowState;
	int __fastcall GetHeight(void);
	int __fastcall GetLeft(void);
	int __fastcall GetTop(void);
	int __fastcall GetWidth(void);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	
public:
	__fastcall virtual TFormStoragePropertyInterceptor(System::TObject* ATarget);
	virtual void __fastcall Readed(void);
	Types::TRect __fastcall GetNotmalFormPlacement();
	
__published:
	__property Controls::TWinControl* ActiveControl = {write=FActiveControl};
	__property int Height = {read=GetHeight, write=FHeight, nodefault};
	__property int Left = {read=GetLeft, write=SetLeft, nodefault};
	__property int PixelsPerInch = {write=FPixelsPerInch, nodefault};
	__property int Top = {read=GetTop, write=SetTop, nodefault};
	__property int Width = {read=GetWidth, write=FWidth, nodefault};
	__property Forms::TWindowState WindowState = {write=FWindowState, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFormStoragePropertyInterceptor(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TReadPropertyInterceptorClass;

//-- var, const, procedure ---------------------------------------------------
extern PACKAGE bool IsRaiseReadErrorEh;
extern PACKAGE void __fastcall GetComponentChildListEh(Classes::TComponent* ParentComp, Classes::TComponent* Root, Classes::TStrings* cl, bool CheckInline);
extern PACKAGE Classes::TComponent* __fastcall FindChildComponent(Classes::TComponent* ParentComp, Classes::TComponent* Root, const AnsiString AName, bool CheckInline);
extern PACKAGE AnsiString __fastcall GetNextPointSeparatedToken(AnsiString Path);
extern PACKAGE void __fastcall RegisterReadPropertyInterceptor(TMetaClass* Target, TMetaClass* Interceptor);
extern PACKAGE void __fastcall UnregisterReadPropertyInterceptor(TMetaClass* Target, TMetaClass* Interceptor);
extern PACKAGE TMetaClass* __fastcall GetInterceptorForTarget(TMetaClass* Target);

}	/* namespace Propfilereh */
using namespace Propfilereh;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Propfilereh
