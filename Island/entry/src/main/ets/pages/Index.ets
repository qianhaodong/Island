import { emitter } from '@kit.BasicServicesKit';
import { EmitEventType, tabData } from '../constants'
import { TabDataType } from '../models'
import { Book } from './Book';
import { Classic } from './Classic';
import { Like } from './Like';

@Entry
@Component
struct Index {
  @State currentName: string = 'classic';

  @Builder TabBarBuilder(item: TabDataType) {
    Column() {
      Image(this.currentName === item.name ? item.iconActive : item.icon)
        .width(24)
        .height(24)

      Text(item.title)
        .fontSize(12)
        .fontColor(this.currentName === item.name ? '#000' : '#c7c7c7')
    }
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      ForEach(tabData, (item: TabDataType) => {
        TabContent() {
          Column() {
            if (item.name === 'classic') {
              Classic()
            } else if (item.name === 'book') {
              Book()
            } else if (item.name === 'like') {
              Like()
            }
          }
        }
        .border({
          color: 'rgba(0,0,0,0.4)',
          width: {
            bottom: 0.5
          }
        })
        .tabBar(this.TabBarBuilder(item))
      })
    }
    .barHeight(60)
    .onTabBarClick((index) => {
      this.currentName = tabData[index].name;
    })
    .onChange((index) => {
      this.currentName = tabData[index].name;

      // 派发切换tab事件
      if (this.currentName === 'classic') {
        emitter.emit({ eventId: EmitEventType.TAB_CLASSIC_SHOW })
      } else {
        emitter.emit({ eventId: EmitEventType.TAB_CLASSIC_HIDE })
      }

      if (this.currentName === 'like') {
        emitter.emit({ eventId: EmitEventType.TAB_LIKE_SHOW })
      } else {
        emitter.emit({ eventId: EmitEventType.TAB_LIKE_HIDE })
      }
    })
  }
}