import { LayoutProbeViewModel } from '../viewmodels/LayoutProbeViewModel';

@ComponentV2
export struct LayoutProbePage {
  @Local vm: LayoutProbeViewModel = new LayoutProbeViewModel();

  build() {
    Column({ space: 8 }) {
      Text($r('app.string.layout_probe_title'))
        .fontSize(13)
        .fontColor($r('app.color.text_primary'))
        .onClick(() => this.vm.goBack())

      Column()
        .width(this.vm.boxW)
        .height(this.vm.boxH)
        .backgroundColor($r('app.color.accent_primary'))
        .borderRadius(10)
        .animation({ duration: 250, curve: Curve.EaseInOut })
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.vm.handleAreaChange(oldValue, newValue);
        })
        .onSizeChange((oldValue: SizeOptions, newValue: SizeOptions) => {
          this.vm.handleSizeChange(oldValue, newValue);
        })

      Text(this.vm.isBig ? $r('app.string.layout_probe_shrink') : $r('app.string.layout_probe_grow'))
        .fontSize(12)
        .fontColor($r('app.color.text_primary'))
        .width('80%')
        .height(30)
        .textAlign(TextAlign.Center)
        .backgroundColor($r('app.color.surface_button'))
        .borderRadius(15)
        .onClick(() => this.vm.toggleSize())

      Column({ space: 2 }) {
        Text($r('app.string.layout_probe_area', this.vm.lastArea))
          .fontSize(9)
          .fontColor($r('app.color.text_body'))
          .maxLines(2)
        Text($r('app.string.layout_probe_size', this.vm.lastSize))
          .fontSize(9)
          .fontColor($r('app.color.text_body'))
          .maxLines(1)
      }
      .width('90%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.app_background'))
  }
}
