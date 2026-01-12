import { Endpoint, PayloadRequest } from 'payload'
import path from 'path'
import { spawn } from 'child_process'

type RequestData = {
  [clusterLabel: string]: { [trialId: string]: number[] }
}

export const heatmapOrdering: Endpoint = {
  path: '/heatmap_ordering',
  method: 'post',
  handler: async (req: PayloadRequest) => {
    if (!req.json) return Response.json({ error: 'No data' }, { status: 400 })

    const data = (await req.json()) as RequestData

    try {
      const result = await new Promise((resolve, reject) => {
        // Corrected path from 'pubilc' to 'public'
        const scriptPath = path.join(process.cwd(), 'public/heatmap_ordering.py')
        // const scriptPath = path.join('/mnt/beta/gpl-odd-payloadcms/public/heatmap_ordering.py')
        const py = spawn('python3', [scriptPath])

        // ADD THIS: Catch the error if the python command fails to start
        py.on('error', (err) => {
          console.error('Failed to start Python process:', err)
        })

        let stdoutData = ''
        let stderrData = ''

        py.stdin.write(JSON.stringify(data))
        py.stdin.end()

        py.stdout.on('data', (chunk) => (stdoutData += chunk))
        py.stderr.on('data', (chunk) => (stderrData += chunk))

        py.on('close', (code) => {
          if (code !== 0) {
            reject(new Error(stderrData || 'Python process exited with error'))
          } else {
            try {
              resolve(JSON.parse(stdoutData))
            } catch (e) {
              reject(new Error('Invalid JSON from Python'))
            }
          }
        })
      })

      return Response.json(result, { status: 200 })
    } catch (error: any) {
      return Response.json({ error: error.message }, { status: 500 })
    }
  },
}
