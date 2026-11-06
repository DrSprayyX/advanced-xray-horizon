# Java translated to Rust

Translated 8 of 186 methods (1 more is done another way in Horizon) and 18 of 30 static fields to Rust; 1 of 3 Fabric event handlers. It's in `runtime.rs`, under `pub mod java`; code that calls the game is in `game_side.rs`.

Each method is translated whole or not at all. A method that can't be (it uses Minecraft, a lambda, null...) is left out with its reason, and so is every method that calls it.

## Why methods were left out

| Cause | Methods | For example |
|---|---|---|
| Calls or uses other code that isn't translated | 155 | `ClientController.onSetup(0)`: it calls XRay.config, which isn't translated |
| Other Java this translator doesn't handle yet | 13 | `ScanType.matches(4)`: it has no body |
| Uses Minecraft classes (needs Horizon's game API) | 9 | `OutlineRender.renderBlocks(1)`: it uses Minecraft's `RenderPass` |
| Done another way in Horizon | 1 | `XRayFabric.onInitializeClient(0)`: done another way in Horizon: it runs as `on_init`, from Horizon's init hook |

## Close, not the same

Where the Rust does a little less than the Java, because Horizon doesn't have something:

- Utils.safeItemStackName: an item's name (getHoverName) leaves out a written book's title and a potion's name

## Fabric event handlers

| Handler | Hook | Result |
|---|---|---|
| pro/mikey/xray/fabric/XRayFabric.java:19 | `tick` | not translated: a handler that isn't a lambda or a Class::method reference |
| pro/mikey/xray/fabric/XRayFabric.java:19 | `hud` | not translated: it calls HudOverlay.renderGameOverlayEvent, which isn't translated |
| pro/mikey/xray/fabric/XRayFabric.java:19 | `init` | `on_init`, called from the hook, without: the call to `HudElementRegistry.addLast(..)`: a lambda |

## Every class


### `ClientController`

- [x] `ClientController.LOGGER` (pro/mikey/xray/ClientController.java:9)
- [ ] `ClientController.onSetup(0)`: it calls XRay.config, which isn't translated (pro/mikey/xray/ClientController.java:11)

### `Configuration`: its constants carry values

- [x] `Configuration.LOGGER` (pro/mikey/xray/Configuration.java:21)
- [x] `Configuration.GSON` (pro/mikey/xray/Configuration.java:22)
- [x] `Configuration.CONFIG_FILE_NAME` (pro/mikey/xray/Configuration.java:23)
- [ ] `Configuration.load(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/Configuration.java:36)
- [ ] `Configuration.save(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/Configuration.java:60)
- [ ] `Configuration.bool(2)`: its class isn't translated (its constants carry values) (pro/mikey/xray/Configuration.java:79)
- [ ] `Configuration.integer(2)`: its class isn't translated (its constants carry values) (pro/mikey/xray/Configuration.java:83)

### `Configuration.ConfigValue`: it's generic

- [ ] `Configuration.ConfigValue.ConfigValue(6)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:96)
- [ ] `Configuration.ConfigValue.get(0)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:108)
- [ ] `Configuration.ConfigValue.set(1)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:116)
- [ ] `Configuration.ConfigValue.write(1)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:121)
- [ ] `Configuration.ConfigValue.read(1)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:138)

### `Configuration.ValueBuilder`: it's generic

- [ ] `Configuration.ValueBuilder.ValueBuilder(4)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:155)
- [ ] `Configuration.ValueBuilder.comment(1)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:162)
- [ ] `Configuration.ValueBuilder.build(0)`: its class isn't translated (it's generic) (pro/mikey/xray/Configuration.java:167)

### `ChunkScanTask`: it implements `Runnable`

- [ ] `ChunkScanTask.ChunkScanTask(2)`: its class isn't translated (it implements `Runnable`) (pro/mikey/xray/core/ChunkScanTask.java:18)
- [ ] `ChunkScanTask.run(0)`: its class isn't translated (it implements `Runnable`) (pro/mikey/xray/core/ChunkScanTask.java:24)

### `OutlineRender`

- [ ] `OutlineRender.NO_DEPTH_LINES_PIPELINE`: it uses Minecraft's `RenderPipeline` (pro/mikey/xray/core/OutlineRender.java:41)
- [ ] `OutlineRender.indices`: it uses Minecraft's `AutoStorageIndexBuffer` (pro/mikey/xray/core/OutlineRender.java:51)
- [ ] `OutlineRender.vertexBuffers`: it uses Minecraft's `ChunkPos` (pro/mikey/xray/core/OutlineRender.java:52)
- [ ] `OutlineRender.chunksToRefresh`: it uses Minecraft's `ChunkPos` (pro/mikey/xray/core/OutlineRender.java:53)
- [ ] `OutlineRender.renderBlocks(1)`: it uses Minecraft's `RenderPass` (pro/mikey/xray/core/OutlineRender.java:55)
- [ ] `OutlineRender.clearVBOs(0)`: it uses OutlineRender.vertexBuffers, which isn't translated (it uses Minecraft's `ChunkPos`) (pro/mikey/xray/core/OutlineRender.java:171)
- [ ] `OutlineRender.clearVBOsFor(1)`: it uses Minecraft's `ChunkPos` (pro/mikey/xray/core/OutlineRender.java:181)
- [ ] `OutlineRender.refreshVBOForChunk(1)`: it uses Minecraft's `ChunkPos` (pro/mikey/xray/core/OutlineRender.java:187)

### `OutlineRender.VBOHolder`: it implements `Closeable` (java.io)

- [ ] `OutlineRender.VBOHolder.VBOHolder(2)`: its class isn't translated (it implements `Closeable` (java.io)) (pro/mikey/xray/core/OutlineRender.java:191)
- [ ] `OutlineRender.VBOHolder.close(0)`: its class isn't translated (it implements `Closeable` (java.io)) (pro/mikey/xray/core/OutlineRender.java:192)
- [ ] `OutlineRender.VBOHolder.vertexBuffer(0)`: its class isn't translated (it implements `Closeable` (java.io)) (pro/mikey/xray/core/OutlineRender.java:191)
- [ ] `OutlineRender.VBOHolder.indexCount(0)`: its class isn't translated (it implements `Closeable` (java.io)) (pro/mikey/xray/core/OutlineRender.java:191)

### `OutlineRenderTarget`

- [x] `OutlineRenderTarget.OutlineRenderTarget(4)` (pro/mikey/xray/core/OutlineRenderTarget.java:3)
- [x] `OutlineRenderTarget.x(0)` (pro/mikey/xray/core/OutlineRenderTarget.java:3)
- [x] `OutlineRenderTarget.y(0)` (pro/mikey/xray/core/OutlineRenderTarget.java:3)
- [x] `OutlineRenderTarget.z(0)` (pro/mikey/xray/core/OutlineRenderTarget.java:3)
- [x] `OutlineRenderTarget.color(0)` (pro/mikey/xray/core/OutlineRenderTarget.java:3)

### `ScanController`: its constants carry values

- [ ] `ScanController.blackList`: its value couldn't be read: an anonymous class (pro/mikey/xray/core/ScanController.java:37)
- [ ] `ScanController.init(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:51)
- [ ] `ScanController.isXRayActive(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:55)
- [ ] `ScanController.toggleXRay(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:59)
- [ ] `ScanController.isLavaActive(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:76)
- [ ] `ScanController.toggleLava(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:80)
- [ ] `ScanController.getRadius(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:84)
- [ ] `ScanController.getHalfRange(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:88)
- [ ] `ScanController.getVisualRadius(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:92)
- [ ] `ScanController.incrementCurrentDist(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:96)
- [ ] `ScanController.decrementCurrentDist(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:104)
- [ ] `ScanController.playerHasMoved(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:112)
- [ ] `ScanController.updatePlayerPosition(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:121)
- [ ] `ScanController.requestBlockFinder(1)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/ScanController.java:125)
- [ ] `ScanController.onBlockChange(3)`: it uses Minecraft's `Level` (pro/mikey/xray/core/ScanController.java:172)

### `BlockScanType`: it extends `ScanType`

- [ ] `BlockScanType.BlockScanType(4)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockScanType.java:16)
- [ ] `BlockScanType.BlockScanType(2)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockScanType.java:23)
- [ ] `BlockScanType.matches(4)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockScanType.java:29)
- [ ] `BlockScanType.writeData(1)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockScanType.java:34)

### `BlockTagScanType`: it extends `ScanType`

- [ ] `BlockTagScanType.BlockTagScanType(5)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockTagScanType.java:16)
- [ ] `BlockTagScanType.BlockTagScanType(2)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockTagScanType.java:21)
- [ ] `BlockTagScanType.matches(4)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockTagScanType.java:26)
- [ ] `BlockTagScanType.writeData(1)`: its class isn't translated (it extends `ScanType`) (pro/mikey/xray/core/scanner/BlockTagScanType.java:31)

### `ScanStore`: a Map or Set keyed by a ScanType

- [x] `ScanStore.GSON` (pro/mikey/xray/core/scanner/ScanStore.java:33)
- [x] `ScanStore.LOGGER` (pro/mikey/xray/core/scanner/ScanStore.java:34)
- [x] `ScanStore.STORE_FILE` (pro/mikey/xray/core/scanner/ScanStore.java:35)
- [ ] `ScanStore.BLOCK_TO_COLOR_DEFAULTS`: it uses LazyValue, which isn't translated (it's generic) (pro/mikey/xray/core/scanner/ScanStore.java:36)
- [ ] `ScanStore.SCAN_TYPE_CREATORS`: it uses Type, which isn't translated (its constants carry values) (pro/mikey/xray/core/scanner/ScanStore.java:57)
- [ ] `ScanStore.createDefaultCategories(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:63)
- [ ] `ScanStore.createDefaultCategory(1)`: it uses Category, which isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:80)
- [ ] `ScanStore.addEntry(1)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:84)
- [ ] `ScanStore.removeEntry(1)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:97)
- [ ] `ScanStore.clearEntries(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:108)
- [ ] `ScanStore.resetToDefaults(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:116)
- [ ] `ScanStore.getNextOrder(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:121)
- [ ] `ScanStore.load(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:126)
- [ ] `ScanStore.loadFromFile(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:131)
- [ ] `ScanStore.save(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:155)
- [ ] `ScanStore.updateActiveTargets(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:173)
- [ ] `ScanStore.categories(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:185)
- [ ] `ScanStore.activeScanTargets(0)`: its class isn't translated (a Map or Set keyed by a ScanType) (pro/mikey/xray/core/scanner/ScanStore.java:189)
- [ ] `ScanStore.fromBlock(1)`: it uses Minecraft's `Block` (pro/mikey/xray/core/scanner/ScanStore.java:193)

### `ScanStore.Category`: it uses Minecraft's `ItemStack`

- [ ] `ScanStore.Category.Category(5)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)
- [ ] `ScanStore.Category.save(1)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:198)
- [ ] `ScanStore.Category.load(1)`: it uses Category, which isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:219)
- [ ] `ScanStore.Category.icon(0)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)
- [ ] `ScanStore.Category.name(0)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)
- [ ] `ScanStore.Category.color(0)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)
- [ ] `ScanStore.Category.order(0)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)
- [ ] `ScanStore.Category.entries(0)`: its class isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/core/scanner/ScanStore.java:197)

### `ScanType`: it uses Type, which isn't translated (its constants carry values)

- [ ] `ScanType.ScanType(5)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:21)
- [ ] `ScanType.ScanType(2)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:30)
- [ ] `ScanType.type(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:39)
- [ ] `ScanType.name(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:43)
- [ ] `ScanType.color(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:47)
- [ ] `ScanType.order(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:51)
- [ ] `ScanType.enabled(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:55)
- [ ] `ScanType.colorInt(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:59)
- [ ] `ScanType.matches(4)`: it has no body (pro/mikey/xray/core/scanner/ScanType.java:63)
- [ ] `ScanType.writeData(1)`: it has no body (pro/mikey/xray/core/scanner/ScanType.java:65)
- [ ] `ScanType.save(0)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:67)
- [ ] `ScanType.updateColor(1)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:78)
- [ ] `ScanType.updateColor(1)`: its class isn't translated (it uses Type, which isn't translated (its constants carry values)) (pro/mikey/xray/core/scanner/ScanType.java:83)
- [ ] `ScanType.parseColor(1)`: it calls `Integer`.parseInt (pro/mikey/xray/core/scanner/ScanType.java:113)
- [ ] `ScanType.randomRgbColor(0)`: Math.random (no random numbers without a crate) (pro/mikey/xray/core/scanner/ScanType.java:197)

### `ScanType.Type`: its constants carry values

- [ ] `ScanType.Type.values`: it uses Type, which isn't translated (its constants carry values) (pro/mikey/xray/core/scanner/ScanType.java:208)
- [ ] `ScanType.Type.Type(1)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/scanner/ScanType.java:211)
- [ ] `ScanType.Type.fromId(1)`: it uses Type, which isn't translated (its constants carry values) (pro/mikey/xray/core/scanner/ScanType.java:215)
- [ ] `ScanType.Type.getId(0)`: its class isn't translated (its constants carry values) (pro/mikey/xray/core/scanner/ScanType.java:225)
- [ ] `LevelRendererMixin`: a Mixin class: its handlers are the injections, in the bundle's helpers (pro/mikey/xray/core/scanner/ScanType.java:15)

### `XPlatShimImpl`: it implements `XPlatShim` (pro.mikey.xray.utils)

- [ ] `XPlatShimImpl.oreTag(0)`: its class isn't translated (it implements `XPlatShim` (pro.mikey.xray.utils)) (pro/mikey/xray/fabric/XPlatShimImpl.java:14)
- [ ] `XPlatShimImpl.configPath(0)`: its class isn't translated (it implements `XPlatShim` (pro.mikey.xray.utils)) (pro/mikey/xray/fabric/XPlatShimImpl.java:19)
- [ ] `XPlatShimImpl.isModLoaded(1)`: its class isn't translated (it implements `XPlatShim` (pro.mikey.xray.utils)) (pro/mikey/xray/fabric/XPlatShimImpl.java:24)

### `XRayFabric`: it implements Fabric's `ClientModInitializer`

- [x] `XRayFabric.HUD_ELEMENT_ID` (pro/mikey/xray/fabric/XRayFabric.java:17)
- [ ] `XRayFabric.onInitializeClient(0)`: done another way in Horizon: it runs as `on_init`, from Horizon's init hook (pro/mikey/xray/fabric/XRayFabric.java:19)
- [ ] `XRayFabric.clientTickEvent(1)`: its class isn't translated (it implements Fabric's `ClientModInitializer`) (pro/mikey/xray/fabric/XRayFabric.java:28)
- [ ] `LevelMixin`: a Mixin class: its handlers are the injections, in the bundle's helpers (pro/mikey/xray/fabric/XRayFabric.java:13)
- [ ] `RenderPipelinesMixin`: a Mixin class: its handlers are the injections, in the bundle's helpers (pro/mikey/xray/fabric/XRayFabric.java:9)

### `FindBlockScreen`: it extends `GuiBase` (pro.mikey.xray.screens.helpers)

- [ ] `FindBlockScreen.FindBlockScreen(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:28)
- [ ] `FindBlockScreen.init(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:32)
- [ ] `FindBlockScreen.tick(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:47)
- [ ] `FindBlockScreen.reloadBlocks(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:55)
- [ ] `FindBlockScreen.removeIgnoredBlocks(0)`: it uses Minecraft's `Block` (pro/mikey/xray/screens/FindBlockScreen.java:70)
- [ ] `FindBlockScreen.renderExtra(4)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:74)
- [ ] `FindBlockScreen.mouseClicked(2)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:80)
- [ ] `FindBlockScreen.mouseScrolled(4)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/FindBlockScreen.java:88)

### `FindBlockScreen.ScrollingBlockList`: it extends Minecraft's `ObjectSelectionList`

- [x] `FindBlockScreen.ScrollingBlockList.SLOT_HEIGHT` (pro/mikey/xray/screens/FindBlockScreen.java:94)
- [ ] `FindBlockScreen.ScrollingBlockList.ScrollingBlockList(4)`: its class isn't translated (it extends Minecraft's `ObjectSelectionList`) (pro/mikey/xray/screens/FindBlockScreen.java:96)
- [ ] `FindBlockScreen.ScrollingBlockList.getRowWidth(0)`: its class isn't translated (it extends Minecraft's `ObjectSelectionList`) (pro/mikey/xray/screens/FindBlockScreen.java:101)
- [ ] `FindBlockScreen.ScrollingBlockList.scrollBarX(0)`: its class isn't translated (it extends Minecraft's `ObjectSelectionList`) (pro/mikey/xray/screens/FindBlockScreen.java:105)
- [ ] `FindBlockScreen.ScrollingBlockList.setSelected(1)`: its class isn't translated (it extends Minecraft's `ObjectSelectionList`) (pro/mikey/xray/screens/FindBlockScreen.java:109)
- [ ] `FindBlockScreen.ScrollingBlockList.updateEntries(1)`: its class isn't translated (it extends Minecraft's `ObjectSelectionList`) (pro/mikey/xray/screens/FindBlockScreen.java:115)

### `FindBlockScreen.ScrollingBlockList.BlockSlot`: it extends Minecraft's `Entry`

- [ ] `FindBlockScreen.ScrollingBlockList.BlockSlot.BlockSlot(2)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/FindBlockScreen.java:125)
- [ ] `FindBlockScreen.ScrollingBlockList.BlockSlot.getBlock(0)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/FindBlockScreen.java:131)
- [ ] `FindBlockScreen.ScrollingBlockList.BlockSlot.extractContent(5)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/FindBlockScreen.java:135)
- [ ] `FindBlockScreen.ScrollingBlockList.BlockSlot.getNarration(0)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/FindBlockScreen.java:143)
- [ ] `FindBlockScreen.ScrollingBlockList.BlockSlot.mouseClicked(2)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/FindBlockScreen.java:147)

### `GuiBase`: it extends Minecraft's `Screen`

- [x] `GuiBase.BG_NORMAL` (pro/mikey/xray/screens/helpers/GuiBase.java:20)
- [ ] `GuiBase.GuiBase(1)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:26)
- [ ] `GuiBase.renderExtra(4)`: it has no body (pro/mikey/xray/screens/helpers/GuiBase.java:31)
- [ ] `GuiBase.charTyped(1)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:33)
- [ ] `GuiBase.extractBackground(4)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:42)
- [ ] `GuiBase.extractRenderState(4)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:89)
- [ ] `GuiBase.getBackground(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:107)
- [ ] `GuiBase.hasTitle(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:111)
- [ ] `GuiBase.title(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:115)
- [ ] `GuiBase.hasSideTitle(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:119)
- [ ] `GuiBase.setSideTitle(1)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:123)
- [ ] `GuiBase.setSize(2)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:127)
- [ ] `GuiBase.getFontRender(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:132)
- [ ] `GuiBase.getWidth(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:136)
- [ ] `GuiBase.getHeight(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:140)
- [ ] `GuiBase.isPauseScreen(0)`: its class isn't translated (it extends Minecraft's `Screen`) (pro/mikey/xray/screens/helpers/GuiBase.java:144)

### `SliderWidget`: it extends Minecraft's `AbstractSliderButton`

- [ ] `SliderWidget.SliderWidget(6)`: its class isn't translated (it extends Minecraft's `AbstractSliderButton`) (pro/mikey/xray/screens/helpers/SliderWidget.java:9)
- [ ] `SliderWidget.updateMessage(0)`: its class isn't translated (it extends Minecraft's `AbstractSliderButton`) (pro/mikey/xray/screens/helpers/SliderWidget.java:14)
- [ ] `SliderWidget.applyValue(0)`: its class isn't translated (it extends Minecraft's `AbstractSliderButton`) (pro/mikey/xray/screens/helpers/SliderWidget.java:18)
- [ ] `SliderWidget.getValue(0)`: its class isn't translated (it extends Minecraft's `AbstractSliderButton`) (pro/mikey/xray/screens/helpers/SliderWidget.java:21)

### `SupportButton`: it extends Minecraft's `Button`

- [ ] `SupportButton.SupportButton(7)`: its class isn't translated (it extends Minecraft's `Button`) (pro/mikey/xray/screens/helpers/SupportButton.java:15)
- [ ] `SupportButton.getSupport(0)`: its class isn't translated (it extends Minecraft's `Button`) (pro/mikey/xray/screens/helpers/SupportButton.java:23)
- [ ] `SupportButton.extractContents(4)`: its class isn't translated (it extends Minecraft's `Button`) (pro/mikey/xray/screens/helpers/SupportButton.java:27)

### `HudOverlay`

- [x] `HudOverlay.CIRCLE` (pro/mikey/xray/screens/HudOverlay.java:14)
- [ ] `HudOverlay.renderGameOverlayEvent(1)`: unknown static ScanController.INSTANCE (pro/mikey/xray/screens/HudOverlay.java:16)

### `ScanConfigureScreen`: it extends `GuiBase` (pro.mikey.xray.screens.helpers)

- [x] `ScanConfigureScreen.TRANSPARENT_BACKGROUND` (pro/mikey/xray/screens/ScanConfigureScreen.java:30)
- [ ] `ScanConfigureScreen.ScanConfigureScreen(2)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:43)
- [ ] `ScanConfigureScreen.ScanConfigureScreen(2)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:50)
- [ ] `ScanConfigureScreen.init(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:62)
- [ ] `ScanConfigureScreen.editBlock(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:116)
- [ ] `ScanConfigureScreen.removeBlock(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:132)
- [ ] `ScanConfigureScreen.addBlock(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:143)
- [ ] `ScanConfigureScreen.tick(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:169)
- [ ] `ScanConfigureScreen.renderExtra(4)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:173)
- [ ] `ScanConfigureScreen.mouseClicked(2)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:188)
- [ ] `ScanConfigureScreen.hasTitle(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:206)
- [ ] `ScanConfigureScreen.title(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanConfigureScreen.java:211)

### `ScanManageScreen`: it extends `GuiBase` (pro.mikey.xray.screens.helpers)

- [x] `ScanManageScreen.EDIT_ICON` (pro/mikey/xray/screens/ScanManageScreen.java:53)
- [ ] `ScanManageScreen.ScanManageScreen(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:59)
- [ ] `ScanManageScreen.init(0)`: its body couldn't be read: an assert (pro/mikey/xray/screens/ScanManageScreen.java:67)
- [ ] `ScanManageScreen.iconButton(4)`: it uses Minecraft's `SpriteIconButton` (pro/mikey/xray/screens/ScanManageScreen.java:163)
- [ ] `ScanManageScreen.confirmResetToDefaults(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:172)
- [ ] `ScanManageScreen.confirmClearAll(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:193)
- [ ] `ScanManageScreen.keyPressed(1)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:214)
- [ ] `ScanManageScreen.updateSearch(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:223)
- [ ] `ScanManageScreen.tick(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:230)
- [ ] `ScanManageScreen.mouseClicked(2)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:235)
- [ ] `ScanManageScreen.renderExtra(4)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:249)
- [ ] `ScanManageScreen.removed(0)`: its class isn't translated (it extends `GuiBase` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:258)

### `ScanManageScreen.ScanEntryScroller`: it extends Minecraft's `ContainerObjectSelectionList`

- [x] `ScanManageScreen.ScanEntryScroller.SLOT_HEIGHT` (pro/mikey/xray/screens/ScanManageScreen.java:264)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanEntryScroller(4)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:266)
- [ ] `ScanManageScreen.ScanEntryScroller.getRowLeft(0)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:272)
- [ ] `ScanManageScreen.ScanEntryScroller.getRowWidth(0)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:276)
- [ ] `ScanManageScreen.ScanEntryScroller.scrollBarX(0)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:280)
- [ ] `ScanManageScreen.ScanEntryScroller.extractListBackground(1)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:284)
- [ ] `ScanManageScreen.ScanEntryScroller.extractListSeparators(1)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:287)
- [ ] `ScanManageScreen.ScanEntryScroller.updateEntries(0)`: its class isn't translated (it extends Minecraft's `ContainerObjectSelectionList`) (pro/mikey/xray/screens/ScanManageScreen.java:290)

### `ScanManageScreen.ScanEntryScroller.ScanSlot`: it extends Minecraft's `Entry`

- [x] `ScanManageScreen.ScanEntryScroller.ScanSlot.INSET` (pro/mikey/xray/screens/ScanManageScreen.java:308)
- [x] `ScanManageScreen.ScanEntryScroller.ScanSlot.SWATCH_SIZE` (pro/mikey/xray/screens/ScanManageScreen.java:309)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.ScanSlot(1)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:315)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.edit(0)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:335)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.extractContent(5)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:339)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.mouseClicked(2)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:357)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.children(0)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:376)
- [ ] `ScanManageScreen.ScanEntryScroller.ScanSlot.narratables(0)`: its class isn't translated (it extends Minecraft's `Entry`) (pro/mikey/xray/screens/ScanManageScreen.java:380)

### `ScanManageScreen.SupportButtonInner`: it extends `SupportButton` (pro.mikey.xray.screens.helpers)

- [ ] `ScanManageScreen.SupportButtonInner.SupportButtonInner(7)`: its class isn't translated (it extends `SupportButton` (pro.mikey.xray.screens.helpers)) (pro/mikey/xray/screens/ScanManageScreen.java:387)

### `LazyValue`: it's generic

- [ ] `LazyValue.LazyValue(1)`: its class isn't translated (it's generic) (pro/mikey/xray/utils/LazyValue.java:9)
- [ ] `LazyValue.of(1)`: it's generic (pro/mikey/xray/utils/LazyValue.java:13)
- [ ] `LazyValue.get(0)`: its class isn't translated (it's generic) (pro/mikey/xray/utils/LazyValue.java:17)

### `Utils`

- [ ] `Utils.safeItemStackName(1)`: a Component where a Component goes (pro/mikey/xray/utils/Utils.java:7)

### `XPlatShim`: it's an interface

- [ ] `XPlatShim.oreTag(0)`: it has no body (pro/mikey/xray/utils/XPlatShim.java:9)
- [ ] `XPlatShim.configPath(0)`: it has no body (pro/mikey/xray/utils/XPlatShim.java:11)
- [ ] `XPlatShim.isModLoaded(1)`: it has no body (pro/mikey/xray/utils/XPlatShim.java:13)

### `XRay`

- [x] `XRay.MOD_ID` (pro/mikey/xray/XRay.java:18)
- [x] `XRay.LOGGER` (pro/mikey/xray/XRay.java:19)
- [ ] `XRay.XPLAT`: it uses XPlatShim, which isn't translated (it's an interface) (pro/mikey/xray/XRay.java:20)
- [ ] `XRay.CATEGORY`: it uses Category, which isn't translated (it uses Minecraft's `ItemStack`) (pro/mikey/xray/XRay.java:21)
- [ ] `XRay.TOGGLE_KEY`: it uses Minecraft's `KeyMapping` (pro/mikey/xray/XRay.java:22)
- [ ] `XRay.OPEN_GUI_KEY`: it uses Minecraft's `KeyMapping` (pro/mikey/xray/XRay.java:23)
- [x] `XRay.init(0)` (pro/mikey/xray/XRay.java:25)
- [ ] `XRay.onToggleKeyPressed(0)`: unknown static ScanController.INSTANCE (pro/mikey/xray/XRay.java:28)
- [ ] `XRay.onOpenGuiKeyPressed(0)`: it calls Minecraft's `Minecraft`.getInstance (pro/mikey/xray/XRay.java:36)
- [ ] `XRay.minecraftNotReady(0)`: it uses Minecraft's `Minecraft` (pro/mikey/xray/XRay.java:44)
- [x] `XRay.id(1)` (pro/mikey/xray/XRay.java:49)
- [x] `XRay.assetLocation(1)` (pro/mikey/xray/XRay.java:53)
- [ ] `XRay.config(0)`: it uses Configuration, which isn't translated (its constants carry values) (pro/mikey/xray/XRay.java:57)
