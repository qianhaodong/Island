import { likeClick, likeClickCancel } from '../api';

@Component
struct Stars {
  @Prop itemId: number = -1;
  @Prop itemType: number = 0;
  @Prop likeStatus: boolean = false;
  @Prop favNums: number = 0;

  build() {
    Row() {
      Image(this.likeStatus ? $r('app.media.love_active_icon') : $r('app.media.love_icon'))
        .width(16)
        .height(14)
        .onClick(() => {
          this.likeStatus = !this.likeStatus;

          const params: Record<string, number | string> = {
            "art_id": this.itemId,
            "type": this.itemType
          };

          if (this.likeStatus) {
            // 点赞
            this.favNums++;
            likeClick(params);
          } else {
            // 取消点赞
            this.favNums;
            likeClickCancel(params);
          }
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