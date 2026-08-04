import { CardItem, EventType } from '../model/EventModels';
import { EventLogService } from '../services/EventLogService';
import { NavigationService } from '../services/NavigationService';

export const CARD_COUNT: number = 8;

export const SEEN_THRESHOLD: number = 0.5;

export const VISIBLE_UPDATE_INTERVAL: number = 200;

@ObservedV2
export class ImpressionProbeViewModel {
  @Trace items: CardItem[] = [];
  @Trace seenCount: number = 0;
  @Trace showHint: boolean = true;
  private seen: Set<number> = new Set<number>();
  private navigation: NavigationService = NavigationService.getInstance();

  init(): void {
    const list: CardItem[] = [];
    for (let i = 1; i <= CARD_COUNT; i++) {
      list.push(new CardItem(i, true));
    }
    this.items = list;
  }

  toggleCard(id: number): void {
    const next: CardItem[] = this.items.map((item: CardItem) => {
      return item.id === id ? new CardItem(item.id, !item.shown) : item;
    });
    this.items = next;
    this.showHint = false;

    const toggled: CardItem | undefined = next.find((c: CardItem) => c.id === id);
    if (toggled !== undefined && !toggled.shown && this.seen.has(id)) {
      this.seen.delete(id);
      this.seenCount = this.seen.size;
    }
  }

  handleVisibleAreaChange(id: number, isExpanding: boolean, currentRatio: number): void {
    const payload: string =
      `card ${id} ratio=${currentRatio.toFixed(2)} ${isExpanding ? 'in' : 'out'}`;
    EventLogService.log(EventType.VISIBLE, payload);

    if (currentRatio >= SEEN_THRESHOLD && !this.seen.has(id)) {
      this.seen.add(id);
      setTimeout(() => {
        this.seenCount = this.seen.size;
      }, 0);
    }
  }

  handleAppear(id: number): void {
    EventLogService.log(EventType.LIFECYCLE, `card ${id} appear`);
  }

  handleDisappear(id: number): void {
    EventLogService.log(EventType.LIFECYCLE, `card ${id} disappear`);
  }

  hideHint(): void {
    this.showHint = false;
  }

  goBack(): void {
    this.navigation.back();
  }
}