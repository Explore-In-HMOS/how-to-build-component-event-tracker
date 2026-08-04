import { common } from '@kit.AbilityKit';

export default class GlobalContext {
  private static instance: GlobalContext;
  private context: common.UIAbilityContext | undefined = undefined;

  static getInstance(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  setCntx(context: common.UIAbilityContext): void {
    this.context = context;
  }

  getCntx(): common.UIAbilityContext | undefined {
    return this.context;
  }
}
