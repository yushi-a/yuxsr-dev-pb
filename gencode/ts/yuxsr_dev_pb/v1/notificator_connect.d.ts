import { NotifyRequest, NotifyResponse } from "./notificator_pb.js";
/**
 * @generated from service yuxsr_dev_pb.v1.NotificatorService
 */
export declare const NotificatorService: {
    readonly typeName: "yuxsr_dev_pb.v1.NotificatorService";
    readonly methods: {
        /**
         * @generated from rpc yuxsr_dev_pb.v1.NotificatorService.Notify
         */
        readonly notify: {
            readonly name: "Notify";
            readonly I: typeof NotifyRequest;
            readonly O: typeof NotifyResponse;
            readonly kind: any;
        };
    };
};
