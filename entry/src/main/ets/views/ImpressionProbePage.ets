import { CardItem } from '../model/EventModels';
import {
  CARD_COUNT,
  ImpressionProbeViewModel,
  SEEN_THRESHOLD,
  VISIBLE_UPDATE_INTERVAL
} from '../viewmodels/ImpressionProbeViewModel';

@ComponentV2
export struct ImpressionProbePage {
  @Local vm: ImpressionProbeViewModel = new ImpressionProbeViewModel();

  aboutToAppear(): void {
    this.vm.init();
  }

  @Builder
  card(item: CardItem) {
    Column() {
      Text($r('app.string.impression_probe_card', item.id))
        .fontSize(12)
        .fontColor($r('app.color.text_primary'))
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.surface'))
    .borderRadius(10)
    .onVisibleAreaApproximateChange(
      { ratios: [0.0, SEEN_THRESHOLD, 1.0], expectedUpdateInterval: VISIBLE_UPDATE_INTERVAL },
      (isExpanding: boolean, currentRatio: number) => {
        this.vm.handleVisibleAreaChange(item.id, isExpanding, currentRatio);
      })
    .onAppear(() => this.vm.handleAppear(item.id))
    .onDisAppear(() => this.vm.handleDisappear(item.id))
  }

  build() {
    Column({ space: 6 }) {
      Text($r('app.string.impression_probe_title'))
        .fontSize(13)
        .fontColor($r('app.color.text_primary'))
        .margin({ top: 6 })
        .onClick(() => this.vm.goBack())

      if (this.vm.showHint) {
        Text($r('app.string.impression_probe_hint'))
          .fontSize(9)
          .fontColor($r('app.color.text_muted'))
      }

      Text($r('app.string.impression_probe_seen', this.vm.seenCount, CARD_COUNT))
        .fontSize(10)
        .fontColor($r('app.color.accent_event'))

      List({ space: 8 }) {
        ForEach(this.vm.items, (item: CardItem) => {
          ListItem() {
            Column() {
              if (item.shown) {
                this.card(item);
              } else {
                Text($r('app.string.impression_probe_card_unmounted', item.id))
                  .fontSize(10)
                  .fontColor($r('app.color.text_muted'))
                  .width('100%')
                  .height(28)
                  .textAlign(TextAlign.Center)
              }
            }
            .width('100%')
            .onClick(() => this.vm.toggleCard(item.id))
          }
        }, (item: CardItem) => `${item.id}-${item.shown}`)
      }
      .width('80%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .contentStartOffset(6)
      .contentEndOffset(50)
      .onScrollStart(() => this.vm.hideHint())
    }
    .width('100%')
    .height('100%')
    .padding({ top: 10 })
    .backgroundColor($r('app.color.app_background'))
  }
}
