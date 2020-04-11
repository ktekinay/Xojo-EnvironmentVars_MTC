#tag Class
Protected Class EnvironmentVarsTests
Inherits TestGroup
	#tag Event
		Sub Setup()
		  MyEnvVars.ClearWriteableVars
		  System.EnvironmentVariable( "READ_ONLY_STRING" ) = "" // Only way to clear it
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AccessTest()
		  Assert.AreEqual "", System.EnvironmentVariable( "READ_WRITE_STRING" )
		  Assert.AreEqual "", MyEnvVars.READ_WRITE_STRING
		  
		  MyEnvVars.READ_WRITE_STRING = "hi"
		  Assert.AreEqual "hi", System.EnvironmentVariable( "READ_WRITE_STRING" )
		  Assert.AreEqual "hi", MyEnvVars.READ_WRITE_STRING
		  
		  Assert.AreEqual "", System.EnvironmentVariable( "READ_WRITE_BOOLEAN" )
		  Assert.IsFalse MyEnvVars.READ_WRITE_BOOLEAN
		  
		  MyEnvVars.READ_WRITE_BOOLEAN = true
		  Assert.AreEqual "yes", System.EnvironmentVariable( "READ_WRITE_BOOLEAN" )
		  Assert.IsTrue MyEnvVars.READ_WRITE_BOOLEAN
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearWriteableVarsTest()
		  MyEnvVars.READ_WRITE_STRING = "Hi there"
		  Assert.AreEqual "Hi there", System.EnvironmentVariable( "READ_WRITE_STRING" )
		  
		  MyEnvVars.READ_WRITE_BOOLEAN = true
		  Assert.AreEqual "yes", System.EnvironmentVariable( "READ_WRITE_BOOLEAN" )
		  
		  System.EnvironmentVariable( "READ_ONLY_STRING" ) = "read only"
		  
		  MyEnvVars.ClearWriteableVars
		  
		  Assert.AreEqual "", System.EnvironmentVariable( "READ_WRITE_STRING" )
		  Assert.AreEqual "", System.EnvironmentVariable( "READ_WRITE_BOOLEAN" )
		  Assert.AreEqual "read only", MyEnvVars.READ_ONLY_STRING
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CountTest()
		  Assert.AreEqual 4, MyEnvVars.Count
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetDisplayValueTest()
		  Assert.AreEqual "<NOT SET>", MyEnvVars.GetDisplayValue( "HIDDEN_STRING" )
		  
		  System.EnvironmentVariable( "HIDDEN_STRING" ) = "password"
		  Assert.AreEqual "password", MyEnvVars.HIDDEN_STRING
		  Assert.AreEqual "<SET>", MyEnvVars.GetDisplayValue( "HIDDEN_STRING" )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetVarNamesTest()
		  dim envVars() as string = MyEnvVars.GetVarNames
		  Assert.AreEqual 3, CType( envVars.Ubound, integer )
		  Assert.AreNotEqual -1, CType( envVars.IndexOf( "READ_WRITE_STRING" ), integer )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToBooleanTest()
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "1" ), "1"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "01" ), "01"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "-1" ), "-1"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "-01" ), "-01"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "10" ), "10"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "010" ), "010"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "-10" ), "-10"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "-010" ), "-010"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "y" ), "y"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "yes" ), "yes"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "t" ), "t"
		  Assert.IsTrue EnvironmentVars_MTC.ToBoolean( "true" ), "true"
		  
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "" ), "<empty>"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "   " ), "<spaces>"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "0" ), "0"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "-0" ), "-0"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "n" ), "n"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "no" ), "no"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "f" ), "f"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "false" ), "false"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "xxx" ), "xxx"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "tr" ), "tr"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "tru" ), "tru"
		  Assert.IsFalse EnvironmentVars_MTC.ToBoolean( "ye" ), "ye"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToDictionaryTest()
		  MyEnvVars.READ_WRITE_STRING = "hi"
		  
		  dim dict as Dictionary = MyEnvVars.ToDictionary
		  
		  Assert.AreEqual MyEnvVars.Count, dict.Count
		  Assert.AreEqual "hi", dict.Value( "READ_WRITE_STRING" ).StringValue
		  Assert.AreEqual "", dict.Value( "READ_WRITE_BOOLEAN" ).StringValue
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
