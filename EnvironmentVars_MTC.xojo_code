#tag Class
Protected Class EnvironmentVars_MTC
	#tag Method, Flags = &h1
		Protected Shared Function BooleanValueFor(methodName As String) As Boolean
		  dim stringValue as string = ValueFor( methodName ).Trim
		  return ToBoolean( stringValue )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub BooleanValueFor(methodName As String, valueSet As BooleanValueSets = BooleanValueSets.YesNo, Assigns value As Boolean)
		  ValueFor( methodName ) = FromBoolean( value, valueSet )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436C65617273207468652076616C7565206F6620657665727920656E7669726F6E6D656E74207661726961626C65
		Sub ClearWriteableVars()
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
		Protected Shared Function ExtractVarName(methodName As String) As String
		  return methodName.NthField( ".", 2 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromBoolean(value As Boolean, valueSet As BooleanValueSets = BooleanValueSets.YesNo) As String
		  dim stringValue as string
		  
		  select case valueSet
		  case BooleanValueSets.YesNo
		    stringValue = if( value, "yes", "no" )
		    
		  case BooleanValueSets.TrueFalse
		    stringValue = if( value, "true", "false" )
		    
		  case BooleanValueSets.OneZero
		    stringValue = if( value, "1", "0" )
		    
		  case else
		    dim err as new UnsupportedFormatException
		    err.Message = "Unknown BooleanValueSets value"
		    raise err
		    
		  end select
		  
		  return stringValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDisplayValue(varName As String, useUnsetValue As String = "<NOT SET>", useHiddenValue As String = "<SET>") As String
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
		Function GetVarNames() As String()
		  dim names() as string
		  
		  for each prop as Introspection.PropertyInfo in GetVarProps
		    names.Append prop.Name
		  next
		  
		  return names
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetVarProps() As Introspection.PropertyInfo()
		  if not WasInitialized then
		    dim tiSuper as Introspection.TypeInfo = GetTypeInfo( EnvironmentVars_MTC )
		    dim superPropNames as new Dictionary
		    for each prop as Introspection.PropertyInfo in tiSuper.GetProperties
		      superPropNames.Value( prop.Name ) = prop
		    next
		    
		    dim ti as Introspection.TypeInfo = Introspection.GetType( self )
		    dim allProps() as Introspection.PropertyInfo = ti.GetProperties
		    
		    for each prop as Introspection.PropertyInfo in allProps
		      if prop.IsComputed and prop.IsPublic and prop.CanRead and superPropNames.HasKey( prop.Name ) = false then
		        VarProps.Append prop
		      end if
		    next
		    
		    WasInitialized = true
		  end if
		  
		  return VarProps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsHiddenValue(prop As Introspection.PropertyInfo) As Boolean
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
		  return match isa RegExMatch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, Description = 436F6E76656E69656E6365206D6574686F6420746F20636F6E7665727420746F20612044696374696F6E617279
		Function ToDictionary() As Dictionary
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
		Private VarProps() As Introspection.PropertyInfo
	#tag EndProperty

	#tag Property, Flags = &h21
		Private WasInitialized As Boolean
	#tag EndProperty


	#tag Constant, Name = kAttributeHideValue, Type = String, Dynamic = False, Default = \"HideValue", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"1.0", Scope = Public
	#tag EndConstant


	#tag Enum, Name = BooleanValueSets, Type = Integer, Flags = &h0
		YesNo
		  TrueFalse
		OneZero
	#tag EndEnum


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
