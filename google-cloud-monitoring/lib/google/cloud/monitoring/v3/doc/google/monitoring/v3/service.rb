# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


module Google
  module Monitoring
    module V3
      # A `Service` is a discrete, autonomous, and network-accessible unit, designed
      # to solve an individual concern
      # ([Wikipedia](https://en.wikipedia.org/wiki/Service-orientation)). In
      # Stackdriver Monitoring, a `Service` acts as the root resource under which
      # operational aspects of the service are accessible.
      # @!attribute [rw] name
      #   @return [String]
      #     Resource name for this Service. Of the form
      #     `projects/{project_id}/services/{service_id}`.
      # @!attribute [rw] display_name
      #   @return [String]
      #     Name used for UI elements listing this Service.
      # @!attribute [rw] custom
      #   @return [Google::Monitoring::V3::Service::Custom]
      #     Custom service type.
      # @!attribute [rw] app_engine
      #   @return [Google::Monitoring::V3::Service::AppEngine]
      #     Type used for App Engine services.
      # @!attribute [rw] cloud_endpoints
      #   @return [Google::Monitoring::V3::Service::CloudEndpoints]
      #     Type used for Cloud Endpoints services.
      # @!attribute [rw] cluster_istio
      #   @return [Google::Monitoring::V3::Service::ClusterIstio]
      #     Type used for Istio services that live in a Kubernetes cluster.
      # @!attribute [rw] telemetry
      #   @return [Google::Monitoring::V3::Service::Telemetry]
      #     Configuration for how to query telemetry on a Service.
      class Service
        # Custom view of service telemetry. Currently a place-holder pending final
        # design.
        class Custom; end

        # App Engine service. Learn more at https://cloud.google.com/appengine.
        # @!attribute [rw] module_id
        #   @return [String]
        #     The ID of the App Engine module underlying this service. Corresponds to
        #     the `module_id` resource label in the `gae_app` monitored resource:
        #     https://cloud.google.com/monitoring/api/resources#tag_gae_app
        class AppEngine; end

        # Cloud Endpoints service. Learn more at https://cloud.google.com/endpoints.
        # @!attribute [rw] service
        #   @return [String]
        #     The name of the Cloud Endpoints service underlying this service.
        #     Corresponds to the `service` resource label in the `api` monitored
        #     resource: https://cloud.google.com/monitoring/api/resources#tag_api
        class CloudEndpoints; end

        # Istio service. Learn more at http://istio.io.
        # @!attribute [rw] location
        #   @return [String]
        #     The location of the Kubernetes cluster in which this Istio service is
        #     defined. Corresponds to the `location` resource label in `k8s_cluster`
        #     resources.
        # @!attribute [rw] cluster_name
        #   @return [String]
        #     The name of the Kubernetes cluster in which this Istio service is
        #     defined. Corresponds to the `cluster_name` resource label in
        #     `k8s_cluster` resources.
        # @!attribute [rw] service_namespace
        #   @return [String]
        #     The namespace of the Istio service underlying this service. Corresponds
        #     to the `destination_service_namespace` metric label in Istio metrics.
        # @!attribute [rw] service_name
        #   @return [String]
        #     The name of the Istio service underlying this service. Corresponds to the
        #     `destination_service_name` metric label in Istio metrics.
        class ClusterIstio; end

        # Configuration for how to query telemetry on a Service.
        # @!attribute [rw] resource_name
        #   @return [String]
        #     The full name of the resource that defines this service. Formatted as
        #     described in https://cloud.google.com/apis/design/resource_names.
        class Telemetry; end
      end

      # A Service-Level Objective (SLO) describes a level of desired good service. It
      # consists of a service-level indicator (SLI), a performance goal, and a period
      # over which the objective is to be evaluated against that goal. The SLO can
      # use SLIs defined in a number of different manners. Typical SLOs might include
      # "99% of requests in each rolling week have latency below 200 milliseconds" or
      # "99.5% of requests in each calendar month return successfully."
      # @!attribute [rw] name
      #   @return [String]
      #     Resource name for this `ServiceLevelObjective`.
      #     Of the form
      #     `projects/{project_id}/services/{service_id}/serviceLevelObjectives/{slo_name}`.
      # @!attribute [rw] display_name
      #   @return [String]
      #     Name used for UI elements listing this SLO.
      # @!attribute [rw] service_level_indicator
      #   @return [Google::Monitoring::V3::ServiceLevelIndicator]
      #     The definition of good service, used to measure and calculate the quality
      #     of the `Service`'s performance with respect to a single aspect of service
      #     quality.
      # @!attribute [rw] goal
      #   @return [Float]
      #     The fraction of service that must be good in order for this objective to be
      #     met. `0 < goal <= 0.999`.
      # @!attribute [rw] rolling_period
      #   @return [Google::Protobuf::Duration]
      #     A rolling time period, semantically "in the past `<rolling_period>`".
      #     Must be an integer multiple of 1 day no larger than 30 days.
      # @!attribute [rw] calendar_period
      #   @return [Google::Type::CalendarPeriod]
      #     A calendar period, semantically "since the start of the current
      #     `<calendar_period>`". At this time, only `DAY`, `WEEK`, `FORTNIGHT`, and
      #     `MONTH` are supported.
      class ServiceLevelObjective
        # `ServiceLevelObjective.View` determines what form of
        # `ServiceLevelObjective` is returned from `GetServiceLevelObjective`,
        # `ListServiceLevelObjectives`, and `ListServiceLevelObjectiveVersions` RPCs.
        module View
          # Same as FULL.
          VIEW_UNSPECIFIED = 0

          # Return the embedded `ServiceLevelIndicator` in the form in which it was
          # defined. If it was defined using a `BasicSli`, return that `BasicSli`.
          FULL = 2

          # For `ServiceLevelIndicator`s using `BasicSli` articulation, instead
          # return the `ServiceLevelIndicator` with its mode of computation fully
          # spelled out as a `RequestBasedSli`. For `ServiceLevelIndicator`s using
          # `RequestBasedSli` or `WindowsBasedSli`, return the
          # `ServiceLevelIndicator` as it was provided.
          EXPLICIT = 1
        end
      end

      # A Service-Level Indicator (SLI) describes the "performance" of a service. For
      # some services, the SLI is well-defined. In such cases, the SLI can be
      # described easily by referencing the well-known SLI and providing the needed
      # parameters. Alternatively, a "custom" SLI can be defined with a query to the
      # underlying metric store. An SLI is defined to be `good_service /
      # total_service` over any queried time interval. The value of performance
      # always falls into the range `0 <= performance <= 1`. A custom SLI describes
      # how to compute this ratio, whether this is by dividing values from a pair of
      # time series, cutting a `Distribution` into good and bad counts, or counting
      # time windows in which the service complies with a criterion. For separation
      # of concerns, a single Service-Level Indicator measures performance for only
      # one aspect of service quality, such as fraction of successful queries or
      # fast-enough queries.
      # @!attribute [rw] basic_sli
      #   @return [Google::Monitoring::V3::BasicSli]
      #     Basic SLI on a well-known service type.
      # @!attribute [rw] request_based
      #   @return [Google::Monitoring::V3::RequestBasedSli]
      #     Request-based SLIs
      # @!attribute [rw] windows_based
      #   @return [Google::Monitoring::V3::WindowsBasedSli]
      #     Windows-based SLIs
      class ServiceLevelIndicator; end

      # An SLI measuring performance on a well-known service type. Performance will
      # be computed on the basis of pre-defined metrics. The type of the
      # `service_resource` determines the metrics to use and the
      # `service_resource.labels` and `metric_labels` are used to construct a
      # monitoring filter to filter that metric down to just the data relevant to
      # this service.
      # @!attribute [rw] method
      #   @return [Array<String>]
      #     OPTIONAL: The set of RPCs to which this SLI is relevant. Telemetry from
      #     other methods will not be used to calculate performance for this SLI. If
      #     omitted, this SLI applies to all the Service's methods. For service types
      #     that don't support breaking down by method, setting this field will result
      #     in an error.
      # @!attribute [rw] location
      #   @return [Array<String>]
      #     OPTIONAL: The set of locations to which this SLI is relevant. Telemetry
      #     from other locations will not be used to calculate performance for this
      #     SLI. If omitted, this SLI applies to all locations in which the Service has
      #     activity. For service types that don't support breaking down by location,
      #     setting this field will result in an error.
      # @!attribute [rw] version
      #   @return [Array<String>]
      #     OPTIONAL: The set of API versions to which this SLI is relevant. Telemetry
      #     from other API versions will not be used to calculate performance for this
      #     SLI. If omitted, this SLI applies to all API versions. For service types
      #     that don't support breaking down by version, setting this field will result
      #     in an error.
      # @!attribute [rw] availability
      #   @return [Google::Monitoring::V3::BasicSli::AvailabilityCriteria]
      #     Good service is defined to be the count of requests made to this service
      #     that return successfully.
      # @!attribute [rw] latency
      #   @return [Google::Monitoring::V3::BasicSli::LatencyCriteria]
      #     Good service is defined to be the count of requests made to this service
      #     that are fast enough with respect to `latency.threshold`.
      class BasicSli
        # Future parameters for the availability SLI.
        class AvailabilityCriteria; end

        # Parameters for a latency threshold SLI.
        # @!attribute [rw] threshold
        #   @return [Google::Protobuf::Duration]
        #     Good service is defined to be the count of requests made to this service
        #     that return in no more than `threshold`.
        class LatencyCriteria; end
      end

      # Range of numerical values, inclusive of `min` and exclusive of `max`. If the
      # open range "< range.max" is desired, set `range.min = -infinity`. If the open
      # range ">= range.min" is desired, set `range.max = infinity`.
      # @!attribute [rw] min
      #   @return [Float]
      #     Range minimum.
      # @!attribute [rw] max
      #   @return [Float]
      #     Range maximum.
      class Range; end

      # Service Level Indicators for which atomic units of service are counted
      # directly.
      # @!attribute [rw] good_total_ratio
      #   @return [Google::Monitoring::V3::TimeSeriesRatio]
      #     `good_total_ratio` is used when the ratio of `good_service` to
      #     `total_service` is computed from two `TimeSeries`.
      # @!attribute [rw] distribution_cut
      #   @return [Google::Monitoring::V3::DistributionCut]
      #     `distribution_cut` is used when `good_service` is a count of values
      #     aggregated in a `Distribution` that fall into a good range. The
      #     `total_service` is the total count of all values aggregated in the
      #     `Distribution`.
      class RequestBasedSli; end

      # A `TimeSeriesRatio` specifies two `TimeSeries` to use for computing the
      # `good_service / total_service` ratio. The specified `TimeSeries` must have
      # `ValueType = DOUBLE` or `ValueType = INT64` and must have `MetricKind =
      # DELTA` or `MetricKind = CUMULATIVE`. The `TimeSeriesRatio` must specify
      # exactly two of good, bad, and total, and the relationship `good_service +
      # bad_service = total_service` will be assumed.
      # @!attribute [rw] good_service_filter
      #   @return [String]
      #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifying a `TimeSeries` quantifying good service provided. Must have
      #     `ValueType = DOUBLE` or `ValueType = INT64` and must have `MetricKind =
      #     DELTA` or `MetricKind = CUMULATIVE`.
      # @!attribute [rw] bad_service_filter
      #   @return [String]
      #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifying a `TimeSeries` quantifying bad service, either demanded service
      #     that was not provided or demanded service that was of inadequate quality.
      #     Must have `ValueType = DOUBLE` or `ValueType = INT64` and must have
      #     `MetricKind = DELTA` or `MetricKind = CUMULATIVE`.
      # @!attribute [rw] total_service_filter
      #   @return [String]
      #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifying a `TimeSeries` quantifying total demanded service. Must have
      #     `ValueType = DOUBLE` or `ValueType = INT64` and must have `MetricKind =
      #     DELTA` or `MetricKind = CUMULATIVE`.
      class TimeSeriesRatio; end

      # A `DistributionCut` defines a `TimeSeries` and thresholds used for measuring
      # good service and total service. The `TimeSeries` must have `ValueType =
      # DISTRIBUTION` and `MetricKind = DELTA` or `MetricKind = CUMULATIVE`. The
      # computed `good_service` will be the count of values x in the `Distribution`
      # such that `range.min <= x < range.max`.
      # @!attribute [rw] distribution_filter
      #   @return [String]
      #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifying a `TimeSeries` aggregating values. Must have `ValueType =
      #     DISTRIBUTION` and `MetricKind = DELTA` or `MetricKind = CUMULATIVE`.
      # @!attribute [rw] range
      #   @return [Google::Monitoring::V3::Range]
      #     Range of values considered "good." For a one-sided range, set one bound to
      #     an infinite value.
      class DistributionCut; end

      # A `WindowsBasedSli` defines `good_service` as the count of time windows for
      # which the provided service was of good quality. Criteria for determining
      # if service was good are embedded in the `window_criterion`.
      # @!attribute [rw] good_bad_metric_filter
      #   @return [String]
      #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
      #     specifying a `TimeSeries` with `ValueType = BOOL`. The window is good if
      #     any `true` values appear in the window.
      # @!attribute [rw] good_total_ratio_threshold
      #   @return [Google::Monitoring::V3::WindowsBasedSli::PerformanceThreshold]
      #     A window is good if its `performance` is high enough.
      # @!attribute [rw] metric_mean_in_range
      #   @return [Google::Monitoring::V3::WindowsBasedSli::MetricRange]
      #     A window is good if the metric's value is in a good range, averaged
      #     across returned streams.
      # @!attribute [rw] metric_sum_in_range
      #   @return [Google::Monitoring::V3::WindowsBasedSli::MetricRange]
      #     A window is good if the metric's value is in a good range, summed across
      #     returned streams.
      # @!attribute [rw] window_period
      #   @return [Google::Protobuf::Duration]
      #     Duration over which window quality is evaluated. Must be an integer
      #     fraction of a day and at least `60s`.
      class WindowsBasedSli
        # A `PerformanceThreshold` is used when each window is good when that window
        # has a sufficiently high `performance`.
        # @!attribute [rw] performance
        #   @return [Google::Monitoring::V3::RequestBasedSli]
        #     `RequestBasedSli` to evaluate to judge window quality.
        # @!attribute [rw] basic_sli_performance
        #   @return [Google::Monitoring::V3::BasicSli]
        #     `BasicSli` to evaluate to judge window quality.
        # @!attribute [rw] threshold
        #   @return [Float]
        #     If window `performance >= threshold`, the window is counted as good.
        class PerformanceThreshold; end

        # A `MetricRange` is used when each window is good when the value x of a
        # single `TimeSeries` satisfies `range.min <= x < range.max`. The provided
        # `TimeSeries` must have `ValueType = INT64` or `ValueType = DOUBLE` and
        # `MetricKind = GAUGE`.
        # @!attribute [rw] time_series
        #   @return [String]
        #     A [monitoring filter](https://cloud.google.com/monitoring/api/v3/filters)
        #     specifying the `TimeSeries` to use for evaluating window quality.
        # @!attribute [rw] range
        #   @return [Google::Monitoring::V3::Range]
        #     Range of values considered "good." For a one-sided range, set one bound
        #     to an infinite value.
        class MetricRange; end
      end
    end
  end
end