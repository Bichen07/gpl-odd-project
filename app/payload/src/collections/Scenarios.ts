import { CollectionConfig } from 'payload'
import xmlFormat from 'xml-formatter'
import { usersAccess } from '../access'
import _ from 'lodash'

const Scenarios: CollectionConfig = {
  slug: 'scenarios',
  access: {
    read: () => true,
    create: usersAccess,
    delete: usersAccess,
    update: usersAccess,
  },
  admin: {
    useAsTitle: 'id',
    group: 'Configs',
  },
  versions: {
    drafts: true,
  },
  fields: [
    {
      name: 'name',
      type: 'text',
    },
    {
      name: 'description',
      type: 'textarea',
      label: 'Description',
      required: true,
    },
    {
      name: 'schematic',
      type: 'upload',
      label: 'Schematic',
      admin: {
        readOnly: true,
        description: 'Will be generated automatically (in the future).',
      },
      relationTo: 'media',
    },
    {
      name: 'testObjectives',
      type: 'group',
      fields: [
        {
          name: 'criticalityMetrics',
          type: 'array',
          admin: {
            description:
              'The criteria to evaluate. The ego vehicle should satisfy all listed criteria.',
          },
          minRows: 1,
          fields: [
            {
              name: 'keyPerformanceIndicator',
              type: 'relationship',
              relationTo: 'keyPerformanceIndicators',
              hasMany: false,
            },
            {
              name: 'threshold',
              type: 'number',
              label: 'Threshold',
              required: true,
            },
            {
              name: 'description',
              type: 'textarea',
            },
          ],
        },
      ],
    },
    {
      name: 'parameters',
      type: 'array',
      label: 'Parameters',
      required: true,
      minRows: 2,
      admin: {
        description: 'The paramter names MUST match those specified in the OpenSCENARIO file.',
        width: '50%',
      },
      fields: [
        {
          name: 'name',
          type: 'text',
          label: 'Name',
        },
        {
          name: 'unit',
          type: 'text',
          label: 'Unit',
        },
        {
          name: 'min',
          type: 'number',
          label: 'Range Min',
        },
        {
          name: 'max',
          type: 'number',
          label: 'Range Max',
        },
        {
          name: 'description',
          type: 'text',
          label: 'Description',
        },
      ],
    },
    {
      name: 'parameterConstraints',
      type: 'array',
      label: 'Parameter Constraints',
      admin: {
        description: 'Extra rule or relationship between parameters.',
      },
      fields: [
        {
          name: 'expression',
          type: 'text',
          label: 'Constraint Expression',
        },
      ],
    },
    {
      name: 'egoTargetSpeed',
      type: 'number',
      label: 'Ego Target Speed (kph)',
      admin: {
        description:
          'The target speed of the ego vehicle. ' +
          'This will overwrite the speed assigned in OpenSCENARIO file. ' +
          'If assigned to -1, the ParameterDeclaration of "EgoSpeed" in the OpenSCENARIO file will be used.',
      },
      defaultValue: 40,
    },
    {
      name: 'openDrive',
      type: 'upload',
      label: 'OpenDRIVE',
      relationTo: 'openDrives',
      required: true,
      admin: {
        description: 'OpenDRIVE path in the OpenSCENARIO file will be overwritten by this.',
      },
    },
    {
      name: 'openScenarioField',
      type: 'group',
      label: 'OpenSCENARIO',
      fields: [
        {
          name: 'type',
          type: 'select',
          label: 'Type',
          options: ['String', 'File'],
        },
        {
          name: 'content',
          type: 'code',
          label: 'Content',
          admin: {
            condition: (_, siblingData) => siblingData.type === 'String',
            description:
              'Should be a XML format string.' +
              'NOTE THAT the OpenDRIVE path in the string will be overwritten.',
            language: 'xml',
            editorOptions: {
              formatOnPaste: true,
              formatOnType: true,
              autoIndent: 'advanced',
              folding: true,
              tabCompletion: 'on',
              tabSize: 4,
            },
          },
          hooks: {
            beforeValidate: [
              ({ value }) => {
                return value
                  ? xmlFormat.minify(value, {
                    filter: (node) => node.type !== 'Comment',
                    collapseContent: true,
                  })
                  : ''
              },
            ],
            afterRead: [({ value }) => (value ? xmlFormat(value) : '')],
          },
        },
        {
          name: 'openScenario',
          type: 'upload',
          label: 'OpenSCENARIO',
          relationTo: 'openScenarios',
          admin: {
            condition: (_, siblingData) => siblingData.type === 'File',
            description: 'NOTE THAT the OpenDRIVE path in the file will be overwritten.',
          },
        },
      ],
    },
    {
      name: 'validConditions',
      type: 'array',
      label: 'Valid Conditions',
      admin: {
        description:
          'The conditions specifiedin the OpenSCENARIO that must be triggered to deem a valid trial. If left empty, every trial is considered valid.',
        width: '50%',
      },
      fields: [
        {
          name: 'condition',
          type: 'text',
          label: 'Condition',
        },
      ],
    },
    {
      name: 'startObservationSamplingConditions',
      type: 'array',
      label: 'Start Observation Sampling Conditions',
      admin: {
        description:
          'The conditions specified in the OpenSCENARIO that must be triggered to start observation sampling. If left empty, observation sampling will start in the beginning.',
        width: '50%',
      },
      fields: [
        {
          name: 'condition',
          type: 'text',
          label: 'Condition',
        },
      ],
    },
    {
      name: 'observationRecordingAgents',
      type: 'array',
      label: 'Observation Recording Agents',
      admin: {
        description:
          'Agents which their names specified in the OpenSCENARIO that we need to track its observations.',
        width: '50%',
      },
      fields: [
        {
          name: 'name',
          type: 'text',
          label: 'Name',
        },
      ],
    },
  ],
}

export default Scenarios
