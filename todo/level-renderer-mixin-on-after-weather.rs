// Not ported yet: the Java @Inject(INVOKE) on LevelRenderer.executeClassicTransparency (LevelRendererMixin.onAfterWeather).
// Why it's off: No Horizon function mapped for LevelRenderer.executeClassicTransparency (run `match`, or map it in a --mappings file).
// horizon-mixins kind: AFTER_CALL
// Note: No Horizon function known for LevelRenderer.executeClassicTransparency: run `match`.
// Note: The call it hooks (WeatherEffectRenderer.render) isn't mapped to a Rust function yet.
//
// Game calls the Java code makes here, and what they are in Horizon:
//   LevelRenderer.executeClassicTransparency -> (not mapped yet)
//   WeatherEffectRenderer.render -> (not mapped yet)
//
// Decompiled Java, pro/mikey/xray/fabric/mixins/LevelRendererMixin.java:16:
// | @Inject(
// |    method = "executeClassicTransparency",
// |    at = @At(
// |       value = "INVOKE",
// |       target = "Lnet/minecraft/client/renderer/WeatherEffectRenderer;render(Lnet/minecraft/client/renderer/state/level/WeatherRenderState;Lcom/mojang/renderpearl/api/commands/RenderPass;)V",
// |       shift = Shift.AFTER
// |    )
// | )
// | public void onAfterWeather(ChunkSectionsToRender chunkSectionsToRender, PreparedFrame featureFrame, RenderPass renderPass, CallbackInfo ci) {
// |    OutlineRender.renderBlocks(renderPass);
// | }
