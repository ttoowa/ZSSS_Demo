﻿Shader "GKit.Shader/Common/Color" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_MaskLayer("Mask Layer", Int) = 0
		_MaskComp("Mask Composition", Int) = 0
		_MaskOp("Mask Operation", Int) = 0
	}

	SubShader{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent"/*"Queue" = "Geometry"*/ }
		Cull Off

		Stencil{
			Ref [_MaskLayer]
			Comp [_MaskComp]
			Pass [_MaskOp]
		}

		Pass{
			CGPROGRAM
			#pragma target 2.0
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f {
				float4 vertex : POSITION;
			};

			fixed4 _Color;

			v2f vert(appdata v) {
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag(v2f i) : COLOR{
				return _Color;
			}
		ENDCG
		}
	}

}
