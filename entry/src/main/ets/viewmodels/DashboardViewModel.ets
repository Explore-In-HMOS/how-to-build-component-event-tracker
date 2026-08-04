import { EventLogStore } from '../model/EventLogStore';
import { LogEntry } from '../model/EventModels';
import { EventLogService } from '../services/EventLogService';
import { NavigationService, Page } from '../services/NavigationService';

@ObservedV2
export class DashboardViewModel {
  private store: EventLogStore = EventLogStore.getInstance();
  private navigation: NavigationService = NavigationService.getInstance();

  get entries(): LogEntry[] {
    return this.store.entries;
  }

  get hasEntries(): boolean {
    return this.store.entries.length > 0;
  }

  countAt(index: number): number {
    return index < this.store.counts.length ? this.store.counts[index] : 0;
  }

  openProbe(target: Page): void {
    this.navigation.navigateTo(target);
  }

  reset(): void {
    EventLogService.reset();
  }
}
