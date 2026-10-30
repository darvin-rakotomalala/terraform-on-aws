/*
   This function listens for S3 events, builds a message with event details,
   and sends it to the configured SNS topic.
*/
const AWS = require("aws-sdk");
const sns = new AWS.SNS();

exports.handler = async (event) => {
    const eventName = event.Records[0].eventName;
    const bucketName = event.Records[0].s3.bucket.name;
    const objectKey = event.Records[0].s3.object.key;

    const message = `S3 Event: ${eventName} occurred in bucket: ${bucketName}, key: ${objectKey}`;

    const params = {
        Message: message,
        TopicArn: process.env.SNS_TOPIC_ARN
    };

    await sns.publish(params).promise();
    return {statusCode: 200, body: JSON.stringify('Notification sent!')};
};
