clear;

video_obj = VideoReader('Appendix4.avi');
frame = read(video_obj, video_obj.NumberOfFrames);
imshow(frame)
