import { likeClick, likeClickCancel } from '../api';
import { to } from '../utils';

@Component
struct Stars {
  @Prop itemId: number = -1;
  @Prop itemType: number = 0;
  @Prop likeStatus: boolean = false;
  @Prop favNums: number = 0;
  @Prop clickable: boolean = true;

  updateData: () => void = () => {};

  build() {
    Row() {
      Image(this.likeStatus ? $r('app.media.love_active_icon') : $r('app.media.love_icon'))
        .width(16)
        .height(14)
        .onClick(async () => {
          if (!this.clickable) return;

          const params: Record<string, number | string> = {
            "art_id": this.itemId,
            "type": this.itemType
          };

          if (this.likeStatus) {
            // 点赞
            await to(likeClickCancel(params));
          } else {
            // 取消点赞
            await to(likeClick(params));
          }

          // 通知页面刷新数据
          this.updateData();
        })

      if (this.favNums) {
        Text(this.favNums.toString())
          .fontSize(10)
          .fontColor('#a1a1a1')
          .offset({
            y: -6,
            x: 1
          })
      }
    }
  }
}

export { Stars }