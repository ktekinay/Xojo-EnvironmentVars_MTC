#tag Class
Protected Class MyEnvVars
Inherits EnvironmentVars_MTC
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ValueFor( CurrentMethodName ) = value
			  
			End Set
		#tag EndSetter
		Attributes( HideValue ) Shared HIDDEN_STRING As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		READ_ONLY_STRING As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return BooleanValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ValueFor( CurrentMethodName ) = if( value, "yes", "no" )
			  
			End Set
		#tag EndSetter
		Shared READ_WRITE_BOOLEAN As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ValueFor( CurrentMethodName ) = value
			  
			End Set
		#tag EndSetter
		Shared READ_WRITE_STRING As String
	#tag EndComputedProperty


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
