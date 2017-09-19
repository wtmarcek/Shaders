Shader "Custom/StandardDiffuse" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_Albedo("Albedo", Color) = (1,1,1,1)
		_MySliderValue("Slider Value", Range(0,10)) = 2.5
	}
		SubShader{
			Tags { "RenderType" = "Opaque" }
			LOD 200

		CGPROGRAM

		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0


		struct Input {
			float2 uv_MainTex;
		};

		float4 _AmbientColor;
		float _MySliderValue;
		fixed4 _Color;

		UNITY_INSTANCING_CBUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_CBUFFER_END

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = pow((_Color + _AmbientColor), _MySliderValue);
			// Albedo comes from a texture tinted by color
			o.Albedo = c.rgb;

			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
