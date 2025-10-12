import type { GenFile, GenMessage, GenService } from "@bufbuild/protobuf/codegenv2";
import type { Message } from "@bufbuild/protobuf";
/**
 * Describes the file yuxsr_dev_pb/v1/notificator.proto.
 */
export declare const file_yuxsr_dev_pb_v1_notificator: GenFile;
/**
 * @generated from message yuxsr_dev_pb.v1.NotifyRequest
 */
export type NotifyRequest = Message<"yuxsr_dev_pb.v1.NotifyRequest"> & {
    /**
     * @generated from field: string message = 1;
     */
    message: string;
};
/**
 * Describes the message yuxsr_dev_pb.v1.NotifyRequest.
 * Use `create(NotifyRequestSchema)` to create a new message.
 */
export declare const NotifyRequestSchema: GenMessage<NotifyRequest>;
/**
 * @generated from message yuxsr_dev_pb.v1.NotifyResponse
 */
export type NotifyResponse = Message<"yuxsr_dev_pb.v1.NotifyResponse"> & {};
/**
 * Describes the message yuxsr_dev_pb.v1.NotifyResponse.
 * Use `create(NotifyResponseSchema)` to create a new message.
 */
export declare const NotifyResponseSchema: GenMessage<NotifyResponse>;
/**
 * @generated from service yuxsr_dev_pb.v1.NotificatorService
 */
export declare const NotificatorService: GenService<{
    /**
     * @generated from rpc yuxsr_dev_pb.v1.NotificatorService.Notify
     */
    notify: {
        methodKind: "unary";
        input: typeof NotifyRequestSchema;
        output: typeof NotifyResponseSchema;
    };
}>;
