import { EVENT_LABELS, LogEntry } from '../model/EventModels';
import { Page } from '../services/NavigationService';
import { clockTime } from '../utils/Formatters';
import { DashboardViewModel } from '../viewmodels/DashboardViewModel';

@ComponentV2
export struct DashboardPage {
  @Local vm: DashboardViewModel = new DashboardViewModel();

  @Builder
  badge(label: Resource, index: number) {
    Column() {
      Text(this.vm.countAt(index).toString())
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .fontColor($r('app.color.text_primary'))
      Text(label)
        .fontSize(9)
        .fontColor($r('app.color.text_secondary'))
    }
    .width(56)
    .height(34)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.surface'))
    .borderRadius(8)
  }

  @Builder
  navButton(label: Resource, target: Page) {
    Text(label)
      .fontSize(12)
      .fontColor($r('app.color.text_primary'))
      .width('100%')
      .height(30)
      .textAlign(TextAlign.Center)
      .backgroundColor($r('app.color.surface_button'))
      .borderRadius(15)
      .onClick(() => this.vm.openProbe(target))
  }

  @Builder
  timelineRow(entry: LogEntry) {
    Row({ space: 6 }) {
      Text(EVENT_LABELS[entry.type])
        .fontSize(9)
        .fontColor($r('app.color.accent_event'))
        .width(40)
      Text(clockTime(entry.timestamp))
        .fontSize(9)
        .fontColor($r('app.color.text_muted'))
        .width(48)
      Text(entry.payload)
        .fontSize(9)
        .fontColor($r('app.color.text_body'))
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
  }

  build() {
    Scroll() {
      Column({ space: 8 }) {
        Text($r('app.string.dashboard_title'))
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
          .margin({ top: 4 })

        Row({ space: 6 }) {
          this.badge(EVENT_LABELS[0], 0)
          this.badge(EVENT_LABELS[1], 1)
        }

        Row({ space: 6 }) {
          this.badge(EVENT_LABELS[2], 2)
          this.badge(EVENT_LABELS[3], 3)
          this.badge(EVENT_LABELS[4], 4)
        }

        Text($r('app.string.dashboard_probes_section'))
          .fontSize(11)
          .fontColor($r('app.color.text_secondary'))
          .margin({ top: 12 })

        Column({ space: 16 }) {
          this.navButton($r('app.string.nav_layout_probe'), Page.LAYOUT_PROBE_PAGE)
          this.navButton($r('app.string.nav_impression_probe'), Page.IMPRESSION_PAGE)
          this.navButton($r('app.string.nav_hover_probe'), Page.ACCESSIBILITY_PAGE)
        }

        Text($r('app.string.dashboard_timeline_section'))
          .fontSize(11)
          .fontColor($r('app.color.text_secondary'))

        if (!this.vm.hasEntries) {
          Text($r('app.string.dashboard_timeline_empty'))
            .fontSize(9)
            .fontColor($r('app.color.text_muted'))
            .height(24)
        } else {
          List({ space: 4 }) {
            ForEach(this.vm.entries, (entry: LogEntry) => {
              ListItem() {
                this.timelineRow(entry)
              }
            }, (entry: LogEntry) => entry.id.toString())
          }
          .width('100%')
          .height(130)
          .scrollBar(BarState.Off)
          .contentEndOffset(6)
        }

        Text($r('app.string.dashboard_reset'))
          .fontSize(12)
          .fontColor($r('app.color.accent_danger'))
          .height(26)
          .onClick(() => this.vm.reset())
      }
      .width('100%')
      .constraintSize({ minHeight: '100%' })
      .justifyContent(FlexAlign.Start)
      .padding({
        left: 30,
        right: 30,
        top: 20,
        bottom: 26
      })
    }
    .width('100%')
    .height('100%')
    .align(Alignment.Top)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .backgroundColor($r('app.color.app_background'))
  }
}
