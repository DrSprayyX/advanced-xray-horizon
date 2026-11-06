// Not ported yet: the Java @Inject(RETURN) on Level.setBlock (LevelMixin.onBlockDestroy).
// Why it's off: `horizon_world::level::Behaviours::set_block` is generic: horizon-mixins rejects generic targets.
// horizon-mixins kind: RETURN on `horizon_world::level::Behaviours::set_block`
// Note: Horizon's RETURN runs at every normal exit and passes the return value on.
//
// Game calls the Java code makes here, and what they are in Horizon:
//   Level.setBlock -> horizon_world::level::Behaviours::set_block (suggested, high)
//
// Decompiled Java, pro/mikey/xray/mixins/LevelMixin.java:14:
// | @Inject(method = "setBlock(Lnet/minecraft/core/BlockPos;Lnet/minecraft/world/level/block/state/BlockState;II)Z", at = @At("RETURN"))
// | public void onBlockDestroy(BlockPos arg, BlockState arg2, int i, int j, CallbackInfoReturnable<Boolean> cir) {
// |    if ((Boolean)cir.getReturnValue()) {
// |       ScanController.onBlockChange((Level)this, arg, arg2);
// |    }
// | }
