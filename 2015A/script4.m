clear;
tic;

start_col = 930;
start_row = 876:895;
video_obj = VideoReader('Appendix4.avi');

start_x = zeros(1,round(video_obj.NumberOfFrames/25));
start_y = zeros(1,round(video_obj.NumberOfFrames/25));
end_x = zeros(1,round(video_obj.NumberOfFrames/25));
end_y = zeros(1,round(video_obj.NumberOfFrames/25));
secs = 0;
for frame_num = 1:25:video_obj.NumberOfFrames
    secs = secs+1;
    frame = read(video_obj, frame_num);
    bw_frame = im2bw(frame, 0.815);
    col0 = start_col;
    row0 = start_row(1);
    while true
        if numel(find(bw_frame(start_row,col0)==false))==numel(start_row)
            col0 = col0+1;
        else
            row0 = start_row(1)+min(find(bw_frame(start_row,col0)==false))-1;
            while true
                if ~bw_frame(row0,col0+1)
                    break
                else
                    row0 = row0+1;
                end
            end
            break
        end
    end
    start_x(secs) = col0;
    start_y(secs) = size(bw_frame,1)-row0;
    col1 = col0+1;
    while true
        if ~bw_frame(row0,col1)
            col0 = col1;
            col1 = col1+1;
        else
            if ~bw_frame(row0-1,col1)
                row0 = row0-1;
            else
                break
            end
        end
    end
    end_x(secs) = col0;
    end_y(secs) = size(bw_frame,1)-row0;
end
figure('Name', '影子起点和终点的轨迹图')
plot(start_x, start_y, 'r.')
hold on
plot(end_x, end_y, 'b.')
hold off
title('影子起点和终点的轨迹(采样时间：秒)')
xlim([0 video_obj.Width])
ylim([0 video_obj.Height])
figure('Name', '影子起点和终点的距离图')
plot(1:numel(start_x), sqrt((end_x-start_x).^2+(end_y-start_y).^2))
xlswrite('output1_1.xlsx', [transpose(1:numel(start_x)) start_x' end_x' start_y' end_y'], 'x-y', 'A2')
toc;
