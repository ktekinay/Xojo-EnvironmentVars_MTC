#tag Class
Protected Class EnvironmentVars_MTC
	#tag Method, Flags = &h1
		Protected Shared Function BooleanValueFor(methodName As String) As Boolean
		  dim stringValue as string = ValueFor( methodName ).Trim
		  return ToBoolean( stringValue )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C65617273207468652076616C7565206F6620657665727920656E7669726F6E6D656E74207661726961626C65
		Shared Sub ClearWriteableVars()
		  //
		  // Clear only the writeable variables
		  //
		  
		  dim props() as Introspection.PropertyInfo = GetVarProps
		  for each prop as Introspection.PropertyInfo in props
		    if prop.CanWrite then
		      System.EnvironmentVariable( prop.Name ) = ""
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  //
		  // Do not instantiate
		  //
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Count() As Integer
		  return VarProps.Ubound + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ExtractVarName(methodName As String) As String
		  return methodName.NthField( ".", 2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetDisplayValue(varName As String, useUnsetValue As String = "<NOT SET>", useHiddenValue As String = "<SET>") As String
		  //
		  // Returns the display value for a property
		  //
		  // Returns the useUnsetValue when there is no value, and
		  // useHiddenValue when the property as the attribute "HideValue"
		  //
		  
		  dim isHidden as boolean
		  
		  for each prop as Introspection.PropertyInfo in GetVarProps
		    if prop.Name = varName then
		      isHidden = IsHiddenValue( prop )
		      exit for prop
		    end if
		  next
		  
		  dim value as string = System.EnvironmentVariable( varName ).Trim
		  
		  if value = "" then
		    value = useUnsetValue
		  elseif isHidden then
		    value = useHiddenValue
		  end if
		  
		  return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetVarNames() As String()
		  dim names() as string
		  
		  for each prop as Introspection.PropertyInfo in GetVarProps
		    names.Append prop.Name
		  next
		  
		  return names
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetVarProps() As Introspection.PropertyInfo()
		  if not WasInited then
		    dim err as new RuntimeException
		    err.Message = "Init(subclassTypeInfo) was must called first"
		    raise err
		  end if
		  
		  static needsInit as boolean = true
		  if needsInit then
		    dim ti as Introspection.TypeInfo = MySubclassTypeInfo
		    dim allProps() as Introspection.PropertyInfo = ti.GetProperties
		    
		    for each prop as Introspection.PropertyInfo in allProps
		      if prop.IsComputed and prop.IsShared and prop.IsPublic and prop.CanRead then
		        VarProps.Append prop
		      end if
		    next
		    
		    needsInit = false
		  end if
		  
		  return VarProps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Init(subclassTypeInfo As Introspection.TypeInfo)
		  MySubclassTypeInfo = subclassTypeInfo
		  wasInited = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function IsHiddenValue(prop As Introspection.PropertyInfo) As Boolean
		  dim atts() as Introspection.AttributeInfo = prop.GetAttributes
		  for each a as Introspection.AttributeInfo in atts
		    if a.Name = kAttributeHideValue then
		      return true
		    end if
		  next
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ToBoolean(stringValue As String) As Boolean
		  stringValue = stringValue.Trim
		  
		  dim trueValues() as string = array( "yes", "y", "true", "t", "1" )
		  if trueValues.IndexOf( stringValue ) <> -1 then
		    return true
		  end if
		  
		  //
		  // See if it's a non-zero number
		  //
		  static rx as RegEx
		  if rx is nil then
		    rx = new RegEx
		    rx.SearchPattern = "\A-?0*[1-9]\d*\z"
		  end if
		  
		  dim match as RegExMatch = rx.Search( stringValue )
		  if match isa RegExMatch then
		    return true
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E76656E69656E6365206D6574686F6420746F20636F6E7665727420746F20612044696374696F6E617279
		Shared Function ToDictionary() As Dictionary
		  dim dict as new Dictionary
		  dim envVars() as string = GetVarNames
		  for each envVar as string in envVars
		    dict.Value( envVar ) = System.EnvironmentVariable( envVar )
		  next
		  
		  return dict
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ValueFor(methodName As String) As String
		  dim envVar as string = ExtractVarName( methodName )
		  return System.EnvironmentVariable( envVar )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub ValueFor(methodName As String, Assigns value As String)
		  dim envVar as string = ExtractVarName( methodName )
		  System.EnvironmentVariable( envVar ) = value
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared MySubclassTypeInfo As Introspection.TypeInfo
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared VarProps() As Introspection.PropertyInfo
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared WasInited As Boolean
	#tag EndProperty


	#tag Constant, Name = kAttributeHideValue, Type = String, Dynamic = False, Default = \"HideValue", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
