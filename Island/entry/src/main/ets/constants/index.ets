import { TabDataType } from '../models';

// tabs导航菜单
export const tabData: TabDataType[] = [
  {
    title: '流行',
    name: 'classic',
    icon: $r('app.media.classic'),
    iconActive: $r('app.media.classic_active')
  },
  {
    title: '书单',
    name: 'book',
    icon: $r('app.media.book'),
    iconActive: $r('app.media.book_active')
  },
  {
    title: '喜欢',
    name: 'like',
    icon: $r("app.media.like"),
    iconActive: $r("app.media.like_active")
  },
];

// 发布、订阅事件枚举
export enum EmitEventType {
  UPDATE_STATE,
  TAB_CLASSIC_SHOW,
  TAB_CLASSIC_HIDE,
  TAB_LIKE_SHOW,
  TAB_LIKE_HIDE,
}