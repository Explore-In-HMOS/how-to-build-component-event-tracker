import { AccessibilityProbeViewModel } from '../viewmodels/AccessibilityProbeViewModel';

@ComponentV2
export struct AccessibilityProbePage {
  @Local vm: AccessibilityProbeViewModel = new AccessibilityProbeViewModel();

  build() {
    Column({ space: 10 }) {
      Text($r('app.string.hover_probe_title'))
        .fontSize(13)
        .fontColor($r('app.color.text_primary'))
        .onClick(() => this.vm.goBack())

      Column() {
        Text($r('app.string.hover_probe_target'))
          .fontSize(12)
          .fontColor($r('app.color.text_primary'))
      }
      .width(160)
      .height(90)
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.accent_primary'))
      .borderRadius(12)
      .onAccessibilityHover((isHover: boolean, event: AccessibilityHoverEvent) => {
        this.vm.handleAccessibilityHover(isHover, event);
      })

      if (this.vm.hasHovered) {
        Text(this.vm.lastHover)
          .fontSize(10)
          .fontColor($r('app.color.text_body'))
      } else {
        Text($r('app.string.hover_probe_empty'))
          .fontSize(10)
          .fontColor($r('app.color.text_body'))
      }

      Text($r('app.string.hover_probe_notice'))
        .fontSize(9)
        .fontColor($r('app.color.text_muted'))
        .width('70%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.app_background'))
  }
}
