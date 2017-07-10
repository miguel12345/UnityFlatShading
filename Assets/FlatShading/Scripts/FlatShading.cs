using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Renderer))]
[ExecuteInEditMode]
public class FlatShading : MonoBehaviour
{
	private Renderer siblingRenderer;
	[SerializeField]
	private Material flatShadingMaterial;
	[SerializeField,HideInInspector]
	private Material originalMaterial;
	
	private void Awake()
	{
		siblingRenderer = GetComponent<Renderer>();
		if(originalMaterial == null)
			originalMaterial = siblingRenderer.sharedMaterial;

		if (flatShadingMaterial == null)
		{
			flatShadingMaterial = new Material(Shader.Find("Custom/FlatShading"));
			flatShadingMaterial.color = originalMaterial.color;
		}
	}

	void OnEnable()
	{
		siblingRenderer.material = flatShadingMaterial;
	}

	void OnDisable()
	{
		siblingRenderer.material = originalMaterial;
	}
}
