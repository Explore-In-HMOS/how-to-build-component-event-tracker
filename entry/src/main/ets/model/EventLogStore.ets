import { EVENT_TYPE_COUNT, LogEntry } from './EventModels';

@ObservedV2
export class EventLogStore {
  private static _instance: EventLogStore;
  @Trace counts: number[] = new Array<number>(EVENT_TYPE_COUNT).fill(0);
  @Trace entries: LogEntry[] = [];

  static getInstance(): EventLogStore {
    if (!EventLogStore._instance) {
      EventLogStore._instance = new EventLogStore();
    }
    return EventLogStore._instance;
  }
}
