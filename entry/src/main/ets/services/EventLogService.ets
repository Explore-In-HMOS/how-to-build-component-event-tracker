import { hilog } from '@kit.PerformanceAnalysisKit';
import { EventLogStore } from '../model/EventLogStore';
import { EventType, EVENT_TYPE_COUNT, LogEntry } from '../model/EventModels';

const MAX_ENTRIES: number = 30;
const DOMAIN: number = 0x9527;
const TAG: string = 'EventProbe';

export class EventLogService {
  private static seq: number = 0;

  static log(type: EventType, payload: string): void {
    const store: EventLogStore = EventLogStore.getInstance();

    const nextCounts: number[] = store.counts.slice();
    nextCounts[type] = nextCounts[type] + 1;
    store.counts = nextCounts;

    EventLogService.seq++;
    const entry: LogEntry = new LogEntry(EventLogService.seq, type, Date.now(), payload);
    store.entries = [entry].concat(store.entries).slice(0, MAX_ENTRIES);

    hilog.info(DOMAIN, TAG, 'type=%{public}d payload=%{public}s', type, payload);
  }

  static reset(): void {
    const store: EventLogStore = EventLogStore.getInstance();
    store.counts = new Array<number>(EVENT_TYPE_COUNT).fill(0);
    store.entries = [];
    EventLogService.seq = 0;
    hilog.info(DOMAIN, TAG, 'log reset');
  }
}
