from pytube import Playlist
import json
from datetime import datetime
import time


def extract_playlist_info(playlist_url):
    try:
        # Create Playlist object
        playlist = Playlist(playlist_url)

        # Initialize list to store video information
        videos_info = []

        # Extract information for each video
        for video in playlist.videos:
            try:
                # Get video details
                video_info = {
                    "title": video.title,
                    "url": f"https://www.youtube.com/watch?v={video.video_id}",
                    "video_id": video.video_id,
                    "author": video.author,
                    "length": video.length,  # Duration in seconds
                    "views": video.views,
                    "publish_date": (
                        video.publish_date.isoformat() if video.publish_date else None
                    ),
                    "description": video.description,
                    "thumbnail_url": video.thumbnail_url,
                }

                videos_info.append(video_info)
                print(f"Processed: {video.title}")

                # Add a small delay to avoid overwhelming the server
                time.sleep(0.5)

            except Exception as e:
                print(f"Error processing video: {str(e)}")
                continue

        if not videos_info:
            print("No videos were successfully processed.")
            return

        # Create the final data structure
        playlist_data = {
            "playlist_url": playlist_url,
            "playlist_title": playlist.title,
            "total_videos": len(videos_info),
            "extraction_date": datetime.now().isoformat(),
            "videos": videos_info,
        }

        # Save to JSON file
        output_file = "playlist_data.json"
        with open(output_file, "w", encoding="utf-8") as f:
            json.dump(playlist_data, f, indent=4, ensure_ascii=False)

        print(f"\nSuccessfully extracted {len(videos_info)} videos")
        print(f"Data saved to {output_file}")

    except Exception as e:
        print(f"Error: {str(e)}")


if __name__ == "__main__":
    playlist_url = (
        "https://youtube.com/playlist?list=PL3409302896110747&si=LWRiEUR28_ZsM-Wc"
    )
    extract_playlist_info(playlist_url)
