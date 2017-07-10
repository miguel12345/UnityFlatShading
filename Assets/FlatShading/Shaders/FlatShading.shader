Shader "Custom/FlatShading" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		
        #include "FlatShadingCore.cginc"

		
		// Physically based Standard lighting model, and enable shadows on all light types
		//We've added the nolightmap config param to keep the number of interpolators below 10.
		//If you want lightmapping, set #pragma target 3.5 
		#pragma surface surfStandard Standard fullforwardshadows nolightmap vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END
		
		void surfStandard (Input IN, inout SurfaceOutputStandard o) {
            o.Normal = calcSurfaceNormalInTangentSpace(IN);
            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
        }
		
		
		ENDCG
	}
	FallBack "Diffuse"
}
