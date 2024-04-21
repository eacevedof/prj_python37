import cv2
import numpy as np
import tensorflow as tf

# Load pre-trained object detection model (for example, using TensorFlow Object Detection API)
# Replace this with the path to your pre-trained model
model_path = 'path_to_your_pretrained_model/frozen_inference_graph.pb'
detection_graph = tf.Graph()
with detection_graph.as_default():
    od_graph_def = tf.compat.v1.GraphDef()
    with tf.compat.v2.io.gfile.GFile(model_path, 'rb') as fid:
        serialized_graph = fid.read()
        od_graph_def.ParseFromString(serialized_graph)
        tf.import_graph_def(od_graph_def, name='')

# Define the labels for detected objects (e.g., 'person', 'ball')
# Replace this with your specific labels
labels = {1: 'person', 2: 'ball'}


# Function to perform object detection on a single frame
def detect_objects(image_np, sess, detection_graph):
    # Expand dimensions since the model expects images to have shape: [1, None, None, 3]
    image_np_expanded = np.expand_dims(image_np, axis=0)
    image_tensor = detection_graph.get_tensor_by_name('image_tensor:0')
    # Each box represents a part of the image where a particular object was detected
    boxes = detection_graph.get_tensor_by_name('detection_boxes:0')
    # Each score represents the level of confidence for each of the objects
    # Score is shown on the result image, together with the class label
    scores = detection_graph.get_tensor_by_name('detection_scores:0')
    classes = detection_graph.get_tensor_by_name('detection_classes:0')
    num_detections = detection_graph.get_tensor_by_name('num_detections:0')

    # Actual detection
    (boxes, scores, classes, num_detections) = sess.run(
        [boxes, scores, classes, num_detections],
        feed_dict={image_tensor: image_np_expanded})

    # Visualization of the results of a detection
    # Draw bounding boxes and labels on the original image
    for i in range(int(num_detections[0])):
        class_id = int(classes[0][i])
        if class_id in labels:
            label = labels[class_id]
            score = float(scores[0][i])
            if score > 0.5:  # Adjust this threshold as needed
                box = boxes[0][i]
                ymin, xmin, ymax, xmax = box
                im_height, im_width, _ = image_np.shape
                (left, right, top, bottom) = (xmin * im_width, xmax * im_width,
                                              ymin * im_height, ymax * im_height)
                # Draw bounding box
                cv2.rectangle(image_np, (int(left), int(top)), (int(right), int(bottom)), (0, 255, 0), 2)
                # Add label and confidence score
                cv2.putText(image_np, '{}: {:.2f}'.format(label, score),
                            (int(left), int(top - 5)), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

    return image_np


# Function to process a video
def process_video(video_path):
    with detection_graph.as_default():
        with tf.compat.v1.Session(graph=detection_graph) as sess:
            # Open video file
            cap = cv2.VideoCapture(video_path)
            while cap.isOpened():
                ret, image_np = cap.read()
                if not ret:
                    break
                # Perform object detection on each frame
                processed_image = detect_objects(image_np, sess, detection_graph)
                # Display the resulting frame
                cv2.imshow('Object Detection', processed_image)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    break
            # Release video capture object
            cap.release()
            cv2.destroyAllWindows()


# Example usage: Process a football video
video_path = 'path_to_your_football_video.mp4'
process_video(video_path)
