# Horizon port report: Advanced XRay (Fabric)

`xray` 26.3.0.4 · advanced-xray-fabric-26.3.0.4.jar · 37 classes

**Partly convertible**

| Status | Count | Meaning |
|---|---|---|
| auto | 4 | The Horizon hook or injection is known: the wiring can be generated. The Java body still has to become Rust. |
| content | 1 | Data and assets: horizon-port-pack carries these into a content mod (.hmod). |
| needs-mapping | 2 | The kind of change carries over, but the matching Horizon function isn't in the table yet. Run `match`. |
| needs-translation | 9 | No direct equivalent: a person (or an AI agent) has to rewrite this part. |
| unsupported | 0 | Horizon has nothing this can attach to yet. |

## Entry points

- `client`: pro.mikey.xray.fabric.XRayFabric

## Fabric events

| Event | In | Horizon | Status | Note |
|---|---|---|---|---|
| KeyMappingHelper.registerKeyMapping | `XRayFabric` | hook `key` | auto | Mojang-named variant of KeyBindingHelper. |
| ClientTickEvents.END_CLIENT_TICK | `XRayFabric` | hook `tick` | auto | START and END of the tick both land on Horizon's one tick hook. |
| ClientLifecycleEvents.CLIENT_STARTED | `XRayFabric` | – | needs-translation | Start/stop: usually the first tick hook call, or nothing. |
| HudElementRegistry.addLast | `XRayFabric` | hook `hud` | auto |  |

## Mixins

| Injection | In | Horizon | Status | Note |
|---|---|---|---|---|
| @Inject(INVOKE) on LevelRenderer.executeClassicTransparency at Lnet/minecraft/client/renderer/WeatherEffectRenderer;render(Lnet/minecraft/client/renderer/state/level/WeatherRenderState;Lcom/mojang/renderpearl/api/commands/RenderPass;)V | `LevelRendererMixin.onAfterWeather` | AFTER_CALL | needs-mapping | No Horizon function known for LevelRenderer.executeClassicTransparency: run `match`. The call it hooks (WeatherEffectRenderer.render) isn't mapped to a Rust function yet. |
| @Inject(RETURN) on Level.setBlock | `LevelMixin.onBlockDestroy` | RETURN on horizon_world::level::Behaviours::set_block | auto | Horizon's RETURN runs at every normal exit and passes the return value on. |
| @Accessor on RenderPipelines.MATRICES_FOG_SNIPPET | `RenderPipelinesMixin.getMatricesFogSnippet` | GET | needs-mapping | A [[bridge]] GET (SET for a setter) on the Rust struct's field. No Horizon function known for RenderPipelines.MATRICES_FOG_SNIPPET: run `match`. |

## Classes extending the game

| Class | In | Status | Note |
|---|---|---|---|
| extends Entry | `FindBlockScreen$ScrollingBlockList$BlockSlot` | needs-translation | No mapping for this superclass yet. |
| extends ObjectSelectionList | `FindBlockScreen$ScrollingBlockList` | needs-translation | No mapping for this superclass yet. |
| extends Entry | `ScanManageScreen$ScanEntryScroller$ScanSlot` | needs-translation | No mapping for this superclass yet. |
| extends ContainerObjectSelectionList | `ScanManageScreen$ScanEntryScroller` | needs-translation | No mapping for this superclass yet. |
| extends Screen | `GuiBase` | needs-translation | No general screen hook; simple option pages can use the settings hook. |
| extends AbstractSliderButton | `SliderWidget` | needs-translation | No mapping for this superclass yet. |
| extends Button | `SupportButton` | needs-translation | No mapping for this superclass yet. |

## Access wideners

| File | In | Status | Note |
|---|---|---|---|
| access widener (opens private game fields) | `xray.accesswidener` | needs-translation | Native helpers already see the game's fields, once each field is mapped. |

## Content

| What | In | Status | Note |
|---|---|---|---|
| 14 asset files, 0 data files | `jar resources` | content | Recipes, loot, tags, models, textures, worldgen: horizon-port-pack carries these. |

## Game methods and fields used

13 of 247 are mapped to Horizon. Every Java body that uses an unmapped one needs it mapped before its Rust can be written.

<details><summary>Mapped</summary>

| Java | Horizon |
|---|---|
| `net/minecraft/client/KeyMapping#<init>` | `self.native_mod_key(MOD_ID, name, default)` |
| `net/minecraft/client/KeyMapping#consumeClick` | `key == self.native_mod_key(..) && pressed, in the key hook` |
| `net/minecraft/client/Minecraft#font` | `(implicit)` |
| `net/minecraft/client/Minecraft#getInstance` | `self` |
| `net/minecraft/client/Minecraft#player` | `self.native_player()` |
| `net/minecraft/client/gui/Font#width` | `self.native_text_width(text)` |
| `net/minecraft/client/gui/screens/Screen#extractBackground` | horizon_client::game::screens::Screen::blurs_background (suggested) |
| `net/minecraft/core/registries/BuiltInRegistries#BLOCK` | content |
| `net/minecraft/network/chat/MutableComponent#withStyle` | horizon_client_core::text::Text::with_style (suggested) |
| `net/minecraft/util/Mth#clamp` | horizon_client_render::chat::clamp (suggested) |
| `net/minecraft/world/level/Level#getMaxY` | horizon_client::game::Dim::max_y (suggested) |
| `net/minecraft/world/level/Level#getMinY` | horizon_client::game::Dim::min_y (suggested) |
| `net/minecraft/world/level/Level#setBlock` | horizon_world::level::Behaviours::set_block (suggested) |

</details>

<details><summary>Not mapped yet</summary>

| Java | Kind | Classes using it |
|---|---|---|
| `com/mojang/blaze3d/platform/InputConstants$Key#getValue` | method | 1 |
| `com/mojang/blaze3d/platform/Window#getGuiScaledHeight` | method | 1 |
| `com/mojang/blaze3d/platform/Window#getGuiScaledWidth` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#bindDefaultUniforms` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#getCompiledPipeline` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#getDevice` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#getDynamicUniforms` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#getModelViewStack` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#getSequentialBuffer` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#setShaderFog` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem#tryGetDevice` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem$AutoStorageIndexBuffer#getBuffer` | method | 1 |
| `com/mojang/blaze3d/systems/RenderSystem$AutoStorageIndexBuffer#type` | method | 1 |
| `com/mojang/blaze3d/vertex/BufferBuilder#<init>` | method | 1 |
| `com/mojang/blaze3d/vertex/BufferBuilder#addVertex` | method | 1 |
| `com/mojang/blaze3d/vertex/BufferBuilder#buildOrThrow` | method | 1 |
| `com/mojang/blaze3d/vertex/ByteBufferBuilder#<init>` | method | 1 |
| `com/mojang/blaze3d/vertex/ByteBufferBuilder#close` | method | 1 |
| `com/mojang/blaze3d/vertex/DefaultVertexFormat#POSITION_COLOR_NORMAL_LINE_WIDTH` | field | 1 |
| `com/mojang/blaze3d/vertex/MeshData#close` | method | 1 |
| `com/mojang/blaze3d/vertex/MeshData#drawState` | method | 1 |
| `com/mojang/blaze3d/vertex/MeshData#vertexBuffer` | method | 1 |
| `com/mojang/blaze3d/vertex/MeshData$DrawState#indexCount` | method | 1 |
| `com/mojang/blaze3d/vertex/VertexConsumer#setColor` | method | 1 |
| `com/mojang/blaze3d/vertex/VertexConsumer#setLineWidth` | method | 1 |
| `com/mojang/blaze3d/vertex/VertexConsumer#setNormal` | method | 1 |
| `net/minecraft/ChatFormatting#GRAY` | field | 1 |
| `net/minecraft/ChatFormatting#WHITE` | field | 1 |
| `net/minecraft/client/Camera#position` | method | 1 |
| `net/minecraft/client/KeyMapping#key` | field | 1 |
| `net/minecraft/client/KeyMapping$Category#register` | method | 1 |
| `net/minecraft/client/Minecraft#gameRenderer` | field | 1 |
| `net/minecraft/client/Minecraft#getSoundManager` | method | 2 |
| `net/minecraft/client/Minecraft#getWindow` | method | 1 |
| `net/minecraft/client/Minecraft#gui` | field | 7 |
| `net/minecraft/client/Minecraft#level` | field | 4 |
| `net/minecraft/client/gui/ActiveTextCollector#acceptScrolling` | method | 1 |
| `net/minecraft/client/gui/Gui#screen` | method | 2 |
| `net/minecraft/client/gui/Gui#setScreen` | method | 6 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#blit` | method | 3 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#fill` | method | 2 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#item` | method | 3 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#text` | method | 5 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#textRenderer` | method | 1 |
| `net/minecraft/client/gui/GuiGraphicsExtractor#tooltip` | method | 1 |
| `net/minecraft/client/gui/components/AbstractSliderButton#<init>` | method | 1 |
| `net/minecraft/client/gui/components/AbstractWidget#playButtonClickSound` | method | 1 |
| `net/minecraft/client/gui/components/Button#<init>` | method | 1 |
| `net/minecraft/client/gui/components/Button#builder` | method | 3 |
| `net/minecraft/client/gui/components/Button#isMouseOver` | method | 1 |
| `net/minecraft/client/gui/components/Button#playDownSound` | method | 1 |
| `net/minecraft/client/gui/components/Button#setMessage` | method | 1 |
| `net/minecraft/client/gui/components/Button$Builder#build` | method | 3 |
| `net/minecraft/client/gui/components/Button$Builder#pos` | method | 1 |
| `net/minecraft/client/gui/components/Button$Builder#size` | method | 3 |
| `net/minecraft/client/gui/components/Button$Builder#tooltip` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#builder` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#extractRenderState` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#getBoxSize` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#getHeight` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#getWidth` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#getX` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#onPress` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#setMessage` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox#setPosition` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox$Builder#build` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox$Builder#maxWidth` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox$Builder#onValueChange` | method | 1 |
| `net/minecraft/client/gui/components/Checkbox$Builder#selected` | method | 1 |
| `net/minecraft/client/gui/components/ContainerObjectSelectionList#<init>` | method | 1 |
| `net/minecraft/client/gui/components/ContainerObjectSelectionList$Entry#<init>` | method | 1 |
| `net/minecraft/client/gui/components/ContainerObjectSelectionList$Entry#mouseClicked` | method | 1 |
| `net/minecraft/client/gui/components/EditBox#<init>` | method | 3 |
| `net/minecraft/client/gui/components/EditBox#extractRenderState` | method | 1 |
| `net/minecraft/client/gui/components/EditBox#extractWidgetRenderState` | method | 1 |
| `net/minecraft/client/gui/components/EditBox#getValue` | method | 4 |
| `net/minecraft/client/gui/components/EditBox#isFocused` | method | 2 |
| `net/minecraft/client/gui/components/EditBox#mouseClicked` | method | 3 |
| `net/minecraft/client/gui/components/EditBox#setCanLoseFocus` | method | 1 |
| `net/minecraft/client/gui/components/EditBox#setFocused` | method | 1 |
| `net/minecraft/client/gui/components/EditBox#setValue` | method | 1 |
| `net/minecraft/client/gui/components/ObjectSelectionList#<init>` | method | 1 |
| `net/minecraft/client/gui/components/ObjectSelectionList$Entry#<init>` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#builder` | method | 3 |
| `net/minecraft/client/gui/components/SpriteIconButton#extractRenderState` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#getHeight` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#getWidth` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#getX` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#setPosition` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton#setTooltip` | method | 3 |
| `net/minecraft/client/gui/components/SpriteIconButton$Builder#build` | method | 3 |
| `net/minecraft/client/gui/components/SpriteIconButton$Builder#narration` | method | 1 |
| `net/minecraft/client/gui/components/SpriteIconButton$Builder#size` | method | 3 |
| `net/minecraft/client/gui/components/SpriteIconButton$Builder#sprite` | method | 3 |
| `net/minecraft/client/gui/components/Tooltip#create` | method | 3 |
| `net/minecraft/client/gui/layouts/EqualSpacingLayout#<init>` | method | 1 |
| `net/minecraft/client/gui/layouts/EqualSpacingLayout#addChild` | method | 1 |
| `net/minecraft/client/gui/layouts/EqualSpacingLayout$Orientation#HORIZONTAL` | field | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#<init>` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#arrangeElements` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#columnSpacing` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#createRowHelper` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#setPosition` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout#visitWidgets` | method | 1 |
| `net/minecraft/client/gui/layouts/GridLayout$RowHelper#addChild` | method | 1 |
| `net/minecraft/client/gui/layouts/LayoutSettings#paddingTop` | method | 1 |
| `net/minecraft/client/gui/layouts/LinearLayout#addChild` | method | 2 |
| `net/minecraft/client/gui/layouts/LinearLayout#arrangeElements` | method | 1 |
| `net/minecraft/client/gui/layouts/LinearLayout#setPosition` | method | 1 |
| `net/minecraft/client/gui/layouts/LinearLayout#spacing` | method | 1 |
| `net/minecraft/client/gui/layouts/LinearLayout#vertical` | method | 1 |
| `net/minecraft/client/gui/layouts/LinearLayout#visitWidgets` | method | 1 |
| `net/minecraft/client/gui/layouts/SpacerElement#height` | method | 1 |
| `net/minecraft/client/gui/screens/ConfirmScreen#<init>` | method | 1 |
| `net/minecraft/client/gui/screens/Screen#<init>` | method | 1 |
| `net/minecraft/client/gui/screens/Screen#charTyped` | method | 1 |
| `net/minecraft/client/gui/screens/Screen#extractRenderState` | method | 1 |
| `net/minecraft/client/gui/screens/inventory/tooltip/ClientTooltipComponent#create` | method | 1 |
| `net/minecraft/client/gui/screens/inventory/tooltip/DefaultTooltipPositioner#INSTANCE` | field | 1 |
| `net/minecraft/client/input/CharacterEvent#codepoint` | method | 1 |
| `net/minecraft/client/input/KeyEvent#key` | method | 1 |
| `net/minecraft/client/input/MouseButtonEvent#button` | method | 2 |
| `net/minecraft/client/input/MouseButtonEvent#hasShiftDown` | method | 1 |
| `net/minecraft/client/input/MouseButtonEvent#x` | method | 1 |
| `net/minecraft/client/input/MouseButtonEvent#y` | method | 1 |
| `net/minecraft/client/multiplayer/ClientLevel#clip` | method | 1 |
| `net/minecraft/client/multiplayer/ClientLevel#getBlockState` | method | 1 |
| `net/minecraft/client/player/LocalPlayer#chunkPosition` | method | 1 |
| `net/minecraft/client/player/LocalPlayer#closeContainer` | method | 1 |
| `net/minecraft/client/player/LocalPlayer#getItemInHand` | method | 1 |
| `net/minecraft/client/player/LocalPlayer#level` | method | 1 |
| `net/minecraft/client/player/LocalPlayer#sendSystemMessage` | method | 2 |
| `net/minecraft/client/renderer/DynamicGpuData#writeTransforms` | method | 1 |
| `net/minecraft/client/renderer/DynamicGpuData$Transform#<init>` | method | 1 |
| `net/minecraft/client/renderer/GameRenderer#mainCamera` | method | 1 |
| `net/minecraft/client/renderer/LevelRenderer#executeClassicTransparency` | method | 1 |
| `net/minecraft/client/renderer/RenderPipelines#GUI_TEXTURED` | field | 3 |
| `net/minecraft/client/renderer/RenderPipelines#MATRICES_FOG_SNIPPET` | method | 1 |
| `net/minecraft/client/renderer/WeatherEffectRenderer#render` | method | 1 |
| `net/minecraft/client/resources/language/I18n#get` | method | 5 |
| `net/minecraft/core/BlockPos#<init>` | method | 1 |
| `net/minecraft/core/BlockPos#getX` | method | 3 |
| `net/minecraft/core/BlockPos#getY` | method | 3 |
| `net/minecraft/core/BlockPos#getZ` | method | 3 |
| `net/minecraft/core/DefaultedRegistry#getKey` | method | 3 |
| `net/minecraft/core/DefaultedRegistry#getValue` | method | 1 |
| `net/minecraft/core/DefaultedRegistry#stream` | method | 2 |
| `net/minecraft/core/Holder$Reference#key` | method | 1 |
| `net/minecraft/core/registries/Registries#BLOCK` | field | 1 |
| `net/minecraft/locale/Language#getInstance` | method | 1 |
| `net/minecraft/locale/Language#getVisualOrder` | method | 1 |
| `net/minecraft/network/chat/CommonComponents#GUI_CANCEL` | field | 1 |
| `net/minecraft/network/chat/Component#empty` | method | 4 |
| `net/minecraft/network/chat/Component#getString` | method | 1 |
| `net/minecraft/network/chat/Component#literal` | method | 6 |
| `net/minecraft/network/chat/Component#translatable` | method | 10 |
| `net/minecraft/network/chat/MutableComponent#getString` | method | 5 |
| `net/minecraft/resources/Identifier#equals` | method | 1 |
| `net/minecraft/resources/Identifier#fromNamespaceAndPath` | method | 1 |
| `net/minecraft/resources/Identifier#getNamespace` | method | 1 |
| `net/minecraft/resources/Identifier#parse` | method | 1 |
| `net/minecraft/resources/Identifier#toString` | method | 3 |
| `net/minecraft/resources/Identifier#tryParse` | method | 2 |
| `net/minecraft/resources/ResourceKey#identifier` | method | 1 |
| `net/minecraft/tags/TagKey#create` | method | 1 |
| `net/minecraft/tags/TagKey#location` | method | 1 |
| `net/minecraft/world/InteractionHand#MAIN_HAND` | field | 1 |
| `net/minecraft/world/entity/player/Player#blockPosition` | method | 1 |
| `net/minecraft/world/entity/player/Player#getEyeHeight` | method | 1 |
| `net/minecraft/world/entity/player/Player#getLookAngle` | method | 1 |
| `net/minecraft/world/entity/player/Player#sendSystemMessage` | method | 1 |
| `net/minecraft/world/item/BlockItem#getBlock` | method | 1 |
| `net/minecraft/world/item/Item#getDefaultInstance` | method | 1 |
| `net/minecraft/world/item/Item#getDescriptionId` | method | 1 |
| `net/minecraft/world/item/ItemStack#<init>` | method | 3 |
| `net/minecraft/world/item/ItemStack#CODEC` | field | 1 |
| `net/minecraft/world/item/ItemStack#EMPTY` | field | 2 |
| `net/minecraft/world/item/ItemStack#getDisplayName` | method | 1 |
| `net/minecraft/world/item/ItemStack#getHoverName` | method | 1 |
| `net/minecraft/world/item/ItemStack#getItem` | method | 2 |
| `net/minecraft/world/level/ChunkPos#<init>` | method | 2 |
| `net/minecraft/world/level/ChunkPos#distanceSquared` | method | 1 |
| `net/minecraft/world/level/ChunkPos#equals` | method | 1 |
| `net/minecraft/world/level/ChunkPos#getMinBlockX` | method | 1 |
| `net/minecraft/world/level/ChunkPos#getMinBlockZ` | method | 1 |
| `net/minecraft/world/level/ChunkPos#x` | method | 2 |
| `net/minecraft/world/level/ChunkPos#z` | method | 2 |
| `net/minecraft/world/level/ClipContext#<init>` | method | 1 |
| `net/minecraft/world/level/ClipContext$Block#OUTLINE` | field | 1 |
| `net/minecraft/world/level/ClipContext$Fluid#NONE` | field | 1 |
| `net/minecraft/world/level/Level#getBlockState` | method | 1 |
| `net/minecraft/world/level/block/Block#asItem` | method | 1 |
| `net/minecraft/world/level/block/Block#builtInRegistryHolder` | method | 1 |
| `net/minecraft/world/level/block/Block#defaultBlockState` | method | 1 |
| `net/minecraft/world/level/block/Block#getName` | method | 4 |
| `net/minecraft/world/level/block/Blocks#AIR` | field | 1 |
| `net/minecraft/world/level/block/Blocks#ANCIENT_DEBRIS` | field | 1 |
| `net/minecraft/world/level/block/Blocks#BEDROCK` | field | 1 |
| `net/minecraft/world/level/block/Blocks#COAL_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_COAL_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_DIAMOND_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_EMERALD_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_GOLD_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_IRON_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_LAPIS_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DEEPSLATE_REDSTONE_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DIAMOND_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#DIRT` | field | 1 |
| `net/minecraft/world/level/block/Blocks#EMERALD_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#GOLD_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#GRASS_BLOCK` | field | 1 |
| `net/minecraft/world/level/block/Blocks#IRON_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#LAPIS_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#LAVA` | field | 1 |
| `net/minecraft/world/level/block/Blocks#NETHER_GOLD_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#NETHER_QUARTZ_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#REDSTONE_ORE` | field | 1 |
| `net/minecraft/world/level/block/Blocks#STONE` | field | 1 |
| `net/minecraft/world/level/block/state/BlockState#getBlock` | method | 2 |
| `net/minecraft/world/level/block/state/BlockState#getFluidState` | method | 2 |
| `net/minecraft/world/level/block/state/BlockState#is` | method | 4 |
| `net/minecraft/world/level/block/state/BlockState#isAir` | method | 1 |
| `net/minecraft/world/level/material/FluidState#getType` | method | 1 |
| `net/minecraft/world/level/material/Fluids#FLOWING_LAVA` | field | 1 |
| `net/minecraft/world/level/material/Fluids#LAVA` | field | 1 |
| `net/minecraft/world/phys/BlockHitResult#getBlockPos` | method | 1 |
| `net/minecraft/world/phys/BlockHitResult#getType` | method | 1 |
| `net/minecraft/world/phys/HitResult$Type#BLOCK` | field | 1 |
| `net/minecraft/world/phys/Vec3#<init>` | method | 1 |
| `net/minecraft/world/phys/Vec3#x` | method | 2 |
| `net/minecraft/world/phys/Vec3#y` | method | 2 |
| `net/minecraft/world/phys/Vec3#z` | method | 2 |
| `net/minecraft/world/phys/shapes/Shapes#block` | method | 1 |
| `net/minecraft/world/phys/shapes/VoxelShape#forAllEdges` | method | 1 |

</details>

