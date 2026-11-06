// Not ported yet: the Java @Accessor on RenderPipelines.MATRICES_FOG_SNIPPET (RenderPipelinesMixin.getMatricesFogSnippet).
// Why it's off: No Horizon function mapped for RenderPipelines.MATRICES_FOG_SNIPPET (run `match`, or map it in a --mappings file).
// horizon-mixins kind: GET
// Note: A [[bridge]] GET (SET for a setter) on the Rust struct's field.
// Note: No Horizon function known for RenderPipelines.MATRICES_FOG_SNIPPET: run `match`.
//
// Game calls the Java code makes here, and what they are in Horizon:
//   RenderPipelines.MATRICES_FOG_SNIPPET -> (not mapped yet)
//
// Decompiled Java, pro/mikey/xray/mixins/RenderPipelinesMixin.java:10:
// | @Accessor("MATRICES_FOG_SNIPPET")
// | static Snippet getMatricesFogSnippet() {
// |    throw new AssertionError();
// | }
