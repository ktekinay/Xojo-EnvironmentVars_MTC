#tag Class
Protected Class EnvironmentVars_MTC
	#tag Method, Flags = &h1
		Protected Shared Function BooleanValueFor(methodName As String) As Boolean
		  var stringValue as string = ValueFor( methodName ).Trim
		  return ToBoolean( stringValue )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  //
		  // Do not instantiate
		  //
		  
		End Sub
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
		  
		  var isHidden as boolean
		  
		  for each prop as Introspection.PropertyInfo in GetVarProps
		    if prop.Name = varName then
		      isHidden = IsHiddenValue( prop )
		      exit for prop
		    end if
		  next
		  
		  var value as string = System.EnvironmentVariable( varName ).Trim
		  
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
		  var names() as string
		  
		  for each prop as Introspection.PropertyInfo in GetVarProps
		    names.AddRow prop.Name
		  next
		  
		  return names
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function GetVarProps() As Introspection.PropertyInfo()
		  if not WasInited then
		    var err as new RuntimeException
		    err.Message = "Init(subclassTypeInfo) was must called first"
		    raise err
		  end if
		  
		  static varProps() as Introspection.PropertyInfo
		  
		  static needsInit as boolean = true
		  if needsInit then
		    var ti as Introspection.TypeInfo = MySubclassTypeInfo
		    var allProps() as Introspection.PropertyInfo = ti.GetProperties
		    
		    for each prop as Introspection.PropertyInfo in allProps
		      if prop.IsComputed and prop.IsShared and prop.IsPublic and prop.CanRead then
		        varProps.AddRow prop
		      end if
		    next
		    
		    needsInit = false
		  end if
		  
		  return varProps
		  
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
		  var atts() as Introspection.AttributeInfo = prop.GetAttributes
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
		  var trueValues() as string = array( "yes", "y", "true", "t", "1" )
		  if trueValues.IndexOf( stringValue ) <> -1 then
		    return true
		  end if
		  
		  //
		  // See if it's a non-zero number
		  //
		  static rx as new RegEx
		  if rx is nil then
		    rx = new RegEx
		    rx.SearchPattern = "\A-?0*[1-9]\d*\z"
		  end if
		  
		  if rx.Search( stringValue ) isa RegExMatch then
		    return true
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function ValueFor(methodName As String) As String
		  var envVar as string = ExtractVarName( methodName )
		  return System.EnvironmentVariable( envVar )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub ValueFor(methodName As String, Assigns value As String)
		  var envVar as string = ExtractVarName( methodName )
		  System.EnvironmentVariable( envVar ) = value
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Shared MySubclassTypeInfo As Introspection.TypeInfo
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
