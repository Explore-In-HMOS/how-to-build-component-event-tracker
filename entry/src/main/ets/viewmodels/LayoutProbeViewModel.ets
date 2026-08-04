import { EventType } from '../model/EventModels';
import { EventLogService } from '../services/EventLogService';
import { NavigationService } from '../services/NavigationService';
import { toNum } from '../utils/Formatters';

const SMALL_W: number = 90;
const SMALL_H: number = 50;
const BIG_W: number = 150;
const BIG_H: number = 90;
const PLACEHOLDER: string = '-';

@ObservedV2
export class LayoutProbeViewModel {
  @Trace boxW: number = SMALL_W;
  @Trace boxH: number = SMALL_H;
  @Trace lastArea: string = PLACEHOLDER;
  @Trace lastSize: string = PLACEHOLDER;
  @Trace isBig: boolean = false;

  private navigation: NavigationService = NavigationService.getInstance();

  toggleSize(): void {
    this.isBig = !this.isBig;
    this.boxW = this.isBig ? BIG_W : SMALL_W;
    this.boxH = this.isBig ? BIG_H : SMALL_H;
  }

  handleAreaChange(oldValue: Area, newValue: Area): void {
    const payload: string =
      `${toNum(oldValue.width)}x${toNum(oldValue.height)} -> ` +
      `${toNum(newValue.width)}x${toNum(newValue.height)} ` +
      `@(${toNum(newValue.position.x)},${toNum(newValue.position.y)})`;
    setTimeout(() => {
      this.lastArea = payload;
    }, 0);
  }

  handleSizeChange(oldValue: SizeOptions, newValue: SizeOptions): void {
    const payload: string =
      `${toNum(oldValue.width)}x${toNum(oldValue.height)} -> ` +
      `${toNum(newValue.width)}x${toNum(newValue.height)}`;
    setTimeout(() => {
      this.lastSize = payload;
    }, 0);
  }

  goBack(): void {
    this.navigation.back();
  }
}