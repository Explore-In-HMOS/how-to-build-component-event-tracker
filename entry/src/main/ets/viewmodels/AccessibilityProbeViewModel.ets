import { EventType } from '../model/EventModels';
import { EventLogService } from '../services/EventLogService';
import { NavigationService } from '../services/NavigationService';

@ObservedV2
export class AccessibilityProbeViewModel {
  @Trace lastHover: string = '';
  private navigation: NavigationService = NavigationService.getInstance();

  get hasHovered(): boolean {
    return this.lastHover.length > 0;
  }

  handleAccessibilityHover(isHover: boolean, event: AccessibilityHoverEvent): void {
    const payload: string =
      `${isHover ? 'enter' : 'exit'} (${Math.round(event.x)},${Math.round(event.y)})`;
    EventLogService.log(EventType.A11Y_HOVER, payload);
    setTimeout(() => {
      this.lastHover = payload;
    }, 0);
  }

  goBack(): void {
    this.navigation.back();
  }
}
