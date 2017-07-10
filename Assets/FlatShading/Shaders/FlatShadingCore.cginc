
struct Input {
    float2 uv_MainTex;
    float3 normal;
    float3 tangent;
    float3 modelPos;
};  		
                  
void vert (inout appdata_full v, out Input o) {
    UNITY_INITIALIZE_OUTPUT(Input,o);
    
    o.normal = v.normal;
    o.tangent = v.tangent.xyz;
    o.modelPos = v.vertex;
}

float3 calcSurfaceNormalInTangentSpace(Input IN) {
    //Since surface shaders require the normal to be in vertex-interpolated tangent space
    //we need to first, get that tangent space, and convert the surface normal to that space
    
    //1 - get interpolated tanget space basis vectors
    float3 tangent = normalize(IN.tangent);
    float3 normal = normalize(IN.normal);
    float3 binormal = normalize(cross(tangent,normal));
    
    //2 - get local-space surface normal
    float3 surfaceNormal = normalize(cross(ddy(IN.modelPos),ddx(IN.modelPos)));
    
    //3 - convert surface normal calculated in 2) to tangent-space calculated in 1)
    float3x3 tangentSpaceBasisMatrix = float3x3(tangent, binormal, normal);
    float3x3 tangentSpaceInverse = transpose(tangentSpaceBasisMatrix); // since we have an orthonormal matrix, the transpose is equal to its inverse
    float3 surfaceNormalInTangentSpace = mul(tangentSpaceInverse,surfaceNormal);
    
    return surfaceNormalInTangentSpace;
}    