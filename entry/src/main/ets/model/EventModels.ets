export enum EventType {
  AREA = 0,
  SIZE = 1,
  VISIBLE = 2,
  LIFECYCLE = 3,
  A11Y_HOVER = 4
}

export const EVENT_TYPE_COUNT: number = 5;

export const EVENT_LABELS: Resource[] = [
  $r('app.string.label_area'),
  $r('app.string.label_size'),
  $r('app.string.label_visible'),
  $r('app.string.label_lifecycle'),
  $r('app.string.label_hover')
];

@ObservedV2
export class LogEntry {
  id: number;
  type: EventType;
  timestamp: number;
  payload: string;

  constructor(id: number, type: EventType, timestamp: number, payload: string) {
    this.id = id;
    this.type = type;
    this.timestamp = timestamp;
    this.payload = payload;
  }
}

@ObservedV2
export class CardItem {
  id: number;
  @Trace shown: boolean;

  constructor(id: number, shown: boolean) {
    this.id = id;
    this.shown = shown;
  }
}