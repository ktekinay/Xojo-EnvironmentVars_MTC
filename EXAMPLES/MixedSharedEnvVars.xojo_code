#tag Class
Protected Class MixedSharedEnvVars
Inherits EnvironmentVars_MTC
	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return BooleanValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  BooleanValueFor( CurrentMethodName ) = value
			  
			End Set
		#tag EndSetter
		BOOLEAN_READ_WRITE As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return BooleanValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		Shared SHARED_BOOLEAN_READ_ONLY As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return ValueFor( CurrentMethodName )
			  
			End Get
		#tag EndGetter
		Shared SHARED_STRING_READ_ONLY As String
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
		STRING_READ_WRITE As String
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
