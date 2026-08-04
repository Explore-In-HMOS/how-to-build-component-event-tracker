import { common } from '@kit.AbilityKit';
import { NavigationService, Page } from '../services/NavigationService';
import GlobalContext from '../utils/GlobalContext';
import { DashboardPage } from '../views/DashboardPage';
import { LayoutProbePage } from '../views/LayoutProbePage';
import { ImpressionProbePage } from '../views/ImpressionProbePage';
import { AccessibilityProbePage } from '../views/AccessibilityProbePage';

@Entry
@ComponentV2
struct Index {
  navigationService: NavigationService = NavigationService.getInstance();

  @Builder
  routeMap(name: string) {
    NavDestination() {
      if (name === Page.DASHBOARD_PAGE) {
        DashboardPage()
      } else if (name === Page.LAYOUT_PROBE_PAGE) {
        LayoutProbePage()
      } else if (name === Page.IMPRESSION_PAGE) {
        ImpressionProbePage()
      } else if (name === Page.ACCESSIBILITY_PAGE) {
        AccessibilityProbePage()
      }
    }
    .onBackPressed(() => {
      if (name === Page.DASHBOARD_PAGE) {
        this.terminateApp();
        return true;
      }
      return false;
    })
    .hideTitleBar(true)
  }

  build() {
    Navigation(this.navigationService.pageInfos)
      .onAppear(() => {
        this.navigationService.navigateTo(Page.DASHBOARD_PAGE);
      })
      .mode(NavigationMode.Stack)
      .navDestination(this.routeMap)
      .hideTitleBar(true)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.app_background'))
  }

  private terminateApp(): void {
    const context = GlobalContext.getInstance().getCntx() as common.UIAbilityContext;
    if (context) {
      context.terminateSelf();
    }
  }
}
